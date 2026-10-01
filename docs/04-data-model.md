# Modèle de données / Data model

![Modèle de données](img/data-model.png)

## Objets

| Objet | Standard / Custom | Rôle | Relations clés |
|---|---|---|---|
| Account | Standard | | |
| Contact | Standard | | |
| Opportunity | Standard | | |
| Product2 / Pricebook2 | Standard | | |
| Quote / QuoteLineItem | Standard | | |
| Order | Standard | | |
| Payment__c | Custom | | |

## Champs personnalisés

| Objet | Champ (API) | Type | Règle / remarque |
|---|---|---|---|
| Account | SIRET__c | Text(14), unique | Validation : exactement 14 chiffres |
| Account | TVA_Intracom__c | Text | |
| Account | Legacy_ID__c | Text, External ID, unique | Clé de migration |
| Payment__c | Stripe_Event_ID__c | Text, External ID, unique | Clé d'idempotence des webhooks |
