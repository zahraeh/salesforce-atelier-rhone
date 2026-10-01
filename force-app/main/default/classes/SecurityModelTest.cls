/**
 * Proves the week 1 security model and data-quality rules against the real
 * roles, sharing rule and permission sets of the org.
 * Users are found by role, not by username (see decision D-11).
 */
@IsTest
private class SecurityModelTest {

    private static final String VALID_SIRET = '12345678900012';

    private static User salesRep(Integer index) {
        List<User> reps = [
            SELECT Id FROM User
            WHERE UserRole.DeveloperName = 'ARE_Commercial' AND IsActive = true
            ORDER BY Username
        ];
        Assert.isTrue(reps.size() >= 2, 'Two active sales reps are needed to test private sharing.');
        return reps[index];
    }

    private static User financeUser() {
        return [
            SELECT Id FROM User
            WHERE UserRole.DeveloperName = 'ARE_Finance' AND IsActive = true
            LIMIT 1
        ];
    }

    private static Account accountOwnedBy(User owner, String siret) {
        Account acc = new Account(Name = 'Client de test', SIRET__c = siret, OwnerId = owner.Id);
        insert acc;
        return acc;
    }

    private static UserRecordAccess accessOf(User u, Id recordId) {
        return [
            SELECT RecordId, HasReadAccess, HasEditAccess
            FROM UserRecordAccess
            WHERE UserId = :u.Id AND RecordId = :recordId
        ];
    }

    // US-01
    @IsTest
    static void repCannotSeeAnotherRepsAccount() {
        User repA = salesRep(0);
        User repB = salesRep(1);
        Account acc = accountOwnedBy(repA, VALID_SIRET);

        System.runAs(repB) {
            Assert.areEqual(0, [SELECT COUNT() FROM Account WHERE Id = :acc.Id],
                'A sales rep must not see an account owned by another rep.');
        }
        System.runAs(repA) {
            Assert.areEqual(1, [SELECT COUNT() FROM Account WHERE Id = :acc.Id],
                'A sales rep must see their own account.');
        }
    }

    // US-03
    @IsTest
    static void financeReadsAllAccountsButCannotEditThem() {
        Account acc = accountOwnedBy(salesRep(0), VALID_SIRET);

        UserRecordAccess access = accessOf(financeUser(), acc.Id);
        Assert.isTrue(access.HasReadAccess, 'Finance must read every account (sharing rule, D-02).');
        Assert.isFalse(access.HasEditAccess, 'Finance must not edit accounts (Q12).');
    }

    // US-03, D-04
    @IsTest
    static void financeCanRecordPaymentOnReadOnlyAccount() {
        Account acc = accountOwnedBy(salesRep(0), VALID_SIRET);

        System.runAs(financeUser()) {
            insert new Payment__c(Account__c = acc.Id, Amount__c = 1200, Status__c = 'Pending');
        }
        Assert.areEqual(1, [SELECT COUNT() FROM Payment__c WHERE Account__c = :acc.Id]);
    }

    // US-01, D-03
    @IsTest
    static void paymentsFollowAccountSharing() {
        User repA = salesRep(0);
        Account acc = accountOwnedBy(repA, VALID_SIRET);
        Payment__c payment = new Payment__c(Account__c = acc.Id, Amount__c = 450, Status__c = 'Pending');
        insert payment;

        System.runAs(repA) {
            Assert.areEqual(1, [SELECT COUNT() FROM Payment__c WHERE Id = :payment.Id],
                'A rep sees payments on their own accounts.');
        }
        System.runAs(salesRep(1)) {
            Assert.areEqual(0, [SELECT COUNT() FROM Payment__c WHERE Id = :payment.Id],
                'A rep must not see payments on another rep\'s accounts.');
        }
    }

    // US-04, D-06
    @IsTest
    static void siretIsRequiredOnCreate() {
        System.runAs(salesRep(0)) {
            try {
                insert new Account(Name = 'Sans SIRET');
                Assert.fail('An account without SIRET must be rejected.');
            } catch (DmlException e) {
                Assert.isTrue(e.getMessage().contains('Le SIRET est obligatoire'), e.getMessage());
            }
        }
    }

    // US-04, D-07
    @IsTest
    static void siretMustHaveFourteenDigits() {
        System.runAs(salesRep(0)) {
            for (String badSiret : new List<String>{ '1234567890001', '1234567890001A', '123 456 789 00012' }) {
                try {
                    insert new Account(Name = 'SIRET invalide', SIRET__c = badSiret.left(14));
                    Assert.fail('SIRET "' + badSiret + '" must be rejected.');
                } catch (DmlException e) {
                    Assert.isTrue(e.getMessage().contains('14 chiffres'), e.getMessage());
                }
            }
        }
    }

    // US-04
    @IsTest
    static void sirenIsDerivedFromSiret() {
        Account acc = accountOwnedBy(salesRep(0), VALID_SIRET);
        Assert.areEqual('123456789', [SELECT SIREN__c FROM Account WHERE Id = :acc.Id].SIREN__c);
    }

    // US-04, D-08
    @IsTest
    static void vatNumberMustMatchSiren() {
        System.runAs(salesRep(0)) {
            insert new Account(Name = 'TVA correcte', SIRET__c = VALID_SIRET, VAT_Number__c = 'FR32123456789');
            try {
                insert new Account(Name = 'TVA incorrecte', SIRET__c = '98765432100018', VAT_Number__c = 'FR32123456789');
                Assert.fail('A VAT number that does not match the SIREN must be rejected.');
            } catch (DmlException e) {
                Assert.isTrue(e.getMessage().contains('ne correspond pas au SIREN'), e.getMessage());
            }
        }
    }

    // US-05, D-05
    @IsTest
    static void duplicateSiretIsBlockedEvenWhenInvisible() {
        accountOwnedBy(salesRep(0), VALID_SIRET);

        System.runAs(salesRep(1)) {
            try {
                insert new Account(Name = 'Doublon', SIRET__c = VALID_SIRET);
                Assert.fail('A duplicate SIRET must be rejected even if the existing account is not visible.');
            } catch (DmlException e) {
                Assert.areEqual(StatusCode.DUPLICATE_VALUE, e.getDmlType(0));
            }
        }
    }

    // US-16, D-06
    @IsTest
    static void migrationUserCanLoadAccountWithoutSiret() {
        User migrationUser = salesRep(1);
        System.runAs(new User(Id = UserInfo.getUserId())) {
            PermissionSet migration = [SELECT Id FROM PermissionSet WHERE Name = 'ARE_Data_Migration'];
            insert new PermissionSetAssignment(AssigneeId = migrationUser.Id, PermissionSetId = migration.Id);
        }

        System.runAs(migrationUser) {
            insert new Account(Name = 'Client historique', Legacy_ID__c = 'CLI-00042');
        }
        Assert.areEqual(1, [SELECT COUNT() FROM Account WHERE Legacy_ID__c = 'CLI-00042']);
    }
}
