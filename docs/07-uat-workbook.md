# Cahier de recette / UAT workbook

*Mis à jour le 1er octobre 2026 · Les cas marqués « Auto » sont rejoués par `SecurityModelTest` à chaque déploiement.*

## Cas de test

| ID | Story | Étape | Résultat attendu | Résultat obtenu | Type | Statut | Anomalie |
|---|---|---|---|---|---|---|---|
| TC-01 | US-01 | Léa Fontaine recherche un compte de Thomas Girard | Compte introuvable | Introuvable | Auto | ✅ | |
| TC-02 | US-01 | Thomas Girard ouvre son propre compte | Compte visible | Visible | Auto | ✅ | |
| TC-03 | US-03 | Hélène Roux (Finance) ouvre un compte de Thomas | Visible en lecture seule | Lecture oui, modification non | Auto | ✅ | |
| TC-04 | US-03 | Hélène Roux crée un paiement sur ce compte | Paiement créé | Créé | Auto | ✅ | |
| TC-05 | US-01 | Thomas voit les paiements de son compte ; Léa ne les voit pas | Visible / invisible | Conforme | Auto | ✅ | |
| TC-06 | US-04 | Créer un compte sans SIRET | Bloqué : « Le SIRET est obligatoire… » | Bloqué | Auto | ✅ | |
| TC-07 | US-04 | Saisir un SIRET de 13 chiffres, avec une lettre, avec des espaces | Bloqué : « …exactement 14 chiffres… » | Bloqué (3 cas) | Auto | ✅ | |
| TC-08 | US-04 | Saisir le SIRET 12345678900012 | SIREN = 123456789 | 123456789 | Auto | ✅ | |
| TC-09 | US-04 | Saisir un n° de TVA qui ne correspond pas au SIREN | Bloqué : « …ne correspond pas au SIREN… » | Bloqué | Auto | ✅ | |
| TC-10 | US-05 | Léa crée un compte avec le SIRET d'un compte de Thomas | Bloqué, sans révéler le propriétaire | Bloqué (valeur en double) | Auto | ✅ | |
| TC-11 | US-16 | L'utilisateur de migration crée un compte sans SIRET | Compte créé | Créé | Auto | ✅ | |
| TC-12 | US-02 | Le directeur commercial modifie un compte de Thomas | Modification enregistrée | Non testable en l'état : l'administratrice joue ce rôle (D-11) | Manuel | ⚠️ | DEF-01 |
| TC-13 | US-01 | Connexion en tant que Thomas : le menu affiche l'onglet Paiements | Onglet visible | À faire | Manuel | ⬜ | |
| TC-14 | US-18 | Saisir une date de consentement sans source | Bloqué : « Indiquez comment le consentement… » | À faire | Manuel | ⬜ | |

## Anomalies

| ID | Date | Description | Gravité | Cause | Correction | Statut |
|---|---|---|---|---|---|---|
| DEF-01 | 01/10/2026 | TC-12 ne prouve rien : l'administratrice voit tout, quel que soit son rôle | Faible | Limite de licences de l'org Developer (D-11) | Accepté pour la démo ; en production, un vrai utilisateur Directeur commercial | Accepté |
