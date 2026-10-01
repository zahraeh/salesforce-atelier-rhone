# User stories

*Version 1.0 · 1er octobre 2026 · Source : [note de cadrage](02-discovery-note.md)*

Format : **En tant que** … **je veux** … **afin de** … Critères d'acceptation en *Étant donné / Quand / Alors*. Priorités MoSCoW (Must, Should, Could).

## Vue d'ensemble

| ID | Rôle | Story (résumé) | Priorité | Semaine | Source |
|---|---|---|---|---|---|
| US-01 | Commercial | Ne voir que mes propres clients | Must | 1 | Q11 |
| US-02 | Directeur commercial | Voir tous les clients et opportunités de l'équipe | Must | 1 | Q11 |
| US-03 | Finance | Consulter tous les clients sans pouvoir modifier les ventes | Must | 1 | Q12 |
| US-04 | Commercial | Saisir un SIRET valide sur chaque compte | Must | 1 | Q09, Q14 |
| US-05 | Commercial | Être empêché de créer un compte en double | Must | 2 | Q09 |
| US-06 | Commercial | Remplir une fiche à partir du seul SIRET | Must | 2 | Q10 |
| US-07 | Commercial | Créer un client avec un formulaire guidé | Should | 2 | Q10, Q20 |
| US-08 | Commercial | Faire un devis avec des produits du catalogue en euros | Must | 2 | Q04 |
| US-09 | Commercial | Indiquer des conditions de paiement conformes à la loi | Must | 2 | Q06 |
| US-10 | Directeur commercial | Valider les remises au-delà de 15 % | Must | 2 | Q05 |
| US-11 | Finance | Recevoir automatiquement la commande quand une affaire est gagnée | Must | 2 | Q03 |
| US-12 | Client (via Finance) | Payer une petite commande en ligne, par carte ou SEPA | Should | 3 | Q07 |
| US-13 | Finance | Voir le statut d'un paiement mis à jour automatiquement | Must | 3 | Q07, Q08 |
| US-14 | Finance | Ne jamais compter deux fois le même paiement | Must | 3 | Q07 |
| US-15 | Commercial | Être prévenu quand le paiement d'un de mes clients échoue | Must | 2 | Q08 |
| US-16 | Finance | Reprendre les clients existants sans doublon | Must | 3 | Q09 |
| US-17 | Directrice générale | Voir le pipeline, les devis et les impayés chaque lundi | Must | 4 | Q17 |
| US-18 | Directrice générale | Tracer le consentement des contacts | Could | 1 | Q16 |
| US-19 | Finance | Avoir les données requises par la facturation électronique | Should | 1 → 3 | Q14 |

---

## Sécurité

### US-01 : ne voir que mes propres clients
**En tant que** commercial, **je veux** ne voir que les comptes dont je suis propriétaire, **afin que** mon portefeuille reste confidentiel.

- Étant donné deux commerciaux A et B, quand A recherche un compte appartenant à B, alors il ne le trouve pas.
- Étant donné un compte appartenant à A, quand A l'ouvre, alors il voit aussi ses contacts, opportunités et paiements.
- Étant donné un compte de B, quand A tente d'y accéder par son URL, alors un message d'accès refusé s'affiche.

### US-02 : voir toute l'équipe
**En tant que** directeur commercial, **je veux** voir et modifier tous les comptes et opportunités de mes commerciaux, **afin de** piloter l'équipe et reprendre un dossier en cas d'absence.

- Étant donné un compte appartenant à n'importe quel commercial, quand le directeur commercial l'ouvre, alors il peut le modifier.

### US-03 : la finance consulte sans modifier les ventes
**En tant que** membre de la finance, **je veux** consulter tous les comptes, **afin de** suivre les paiements, sans pouvoir modifier les devis ni les opportunités.

- Étant donné un compte de n'importe quel commercial, quand la finance l'ouvre, alors elle le voit en lecture seule.
- Étant donné un paiement, quand la finance le modifie, alors la modification est enregistrée.

---

## Données clients

### US-04 : un SIRET valide sur chaque compte
**En tant que** commercial, **je veux** que le SIRET soit contrôlé à la saisie, **afin que** les données soient fiables pour la facturation.

- Quand je saisis un SIRET qui ne contient pas exactement 14 chiffres, alors un message d'erreur clair s'affiche sous le champ et l'enregistrement est bloqué.
- Quand je saisis un SIRET valide, alors le SIREN (9 premiers chiffres) est calculé automatiquement.
- Quand je saisis un numéro de TVA, alors il doit avoir le format français : « FR » suivi de 11 caractères.

### US-05 : pas de compte en double
**En tant que** commercial, **je veux** être bloqué si le SIRET existe déjà, **afin de** ne pas créer de doublon.

- Étant donné un compte existant avec le SIRET 12345678900012, quand je crée un compte avec le même SIRET, alors la création est bloquée, même si le compte existant appartient à un autre commercial.
- Le message ne révèle pas le nom du propriétaire du compte existant.

### US-06 : remplir une fiche à partir du SIRET
**En tant que** commercial, **je veux** saisir un SIRET et obtenir la raison sociale, l'adresse et le code NAF, **afin de** ne plus rien ressaisir.

- Étant donné un SIRET existant, quand je clique sur « Enrichir depuis le SIRET », alors la raison sociale, l'adresse et le code NAF sont remplis.
- Étant donné un SIRET inconnu, alors un message « Entreprise introuvable » s'affiche et rien n'est modifié.
- Étant donné que l'API ne répond pas, alors un message invite à réessayer plus tard et rien n'est modifié.

### US-07 : formulaire « Nouveau client »
**En tant que** commercial, **je veux** un formulaire guidé pour créer un client et son premier contact, **afin de** le faire en moins de 2 minutes.

- Le formulaire demande le SIRET en premier, propose l'enrichissement, puis le contact principal.
- À la fin, le compte et le contact sont créés et je suis redirigé vers le compte.

### US-16 : reprise des clients existants
**En tant que** membre de la finance, **je veux** que les clients Excel soient repris sans doublon, **afin de** démarrer sur une base propre.

- Chaque compte repris porte son identifiant d'origine (`Legacy_ID__c`).
- Un rapport de réconciliation indique : lignes source, doublons fusionnés, comptes chargés, lignes rejetées, avec un écart inexpliqué de 0.
- Relancer le chargement ne crée aucun doublon.

### US-18 : consentement des contacts (RGPD)
**En tant que** directrice générale, **je veux** savoir quand et comment chaque contact a donné son consentement, **afin de** respecter le RGPD.

- Chaque contact a une date de consentement, une source et une case « Opposition ».
- Quand la case « Opposition » est cochée, alors la date d'opposition est enregistrée.

### US-19 : données pour la facturation électronique
**En tant que** membre de la finance, **je veux** que chaque compte ait un SIREN, un numéro de TVA et une adresse de facturation, **afin d'**être prête pour la réforme.

- Un rapport liste les comptes à qui il manque l'une de ces informations.

---

## Devis et commandes

### US-08 : devis depuis le catalogue
**En tant que** commercial, **je veux** créer un devis avec les produits du catalogue en euros, **afin de** ne plus utiliser de modèle Excel.

- Le devis est lié à une opportunité et utilise le catalogue de prix standard en euros.
- Le PDF du devis affiche les lignes, les remises, le total HT, la TVA et le total TTC.

### US-09 : conditions de paiement conformes
**En tant que** commercial, **je veux** choisir des conditions de paiement dans une liste, **afin de** ne jamais proposer un délai illégal.

- Les valeurs possibles sont : comptant, 30 jours, 45 jours fin de mois, 60 jours.
- Aucune valeur au-delà de 60 jours n'est possible (LME).

### US-10 : approbation des remises
**En tant que** directeur commercial, **je veux** valider toute remise supérieure à 15 %, **afin de** protéger la marge.

- Quand un devis a une remise supérieure à 15 %, alors il ne peut pas être envoyé avant approbation.
- Le directeur commercial reçoit une demande et peut approuver ou rejeter avec un commentaire.
- Une remise de 15 % exactement ne déclenche pas d'approbation.

### US-11 : commande créée à la signature
**En tant que** membre de la finance, **je veux** qu'une commande soit créée quand une opportunité est gagnée, **afin de** ne plus rien ressaisir.

- Quand une opportunité passe à « Gagnée », alors une commande est créée avec le compte, le montant et les produits du devis synchronisé.
- La finance reçoit une notification avec un lien vers la commande.
- Si l'opportunité repasse à « Gagnée » une seconde fois, aucune seconde commande n'est créée.

---

## Paiements

### US-12 : paiement en ligne
**En tant que** client, **je veux** payer une petite commande par carte ou par prélèvement SEPA, **afin de** ne pas attendre une facture pour régler.

- Un paiement Stripe (mode test) est créé pour la commande, avec l'identifiant de commande Salesforce dans ses métadonnées.

### US-13 : statut de paiement automatique
**En tant que** membre de la finance, **je veux** que le statut d'un paiement se mette à jour seul, **afin de** ne plus pointer à la main.

- Quand Stripe signale un paiement réussi, échoué ou remboursé, alors le paiement correspondant passe au statut « Reçu », « Échoué » ou « Remboursé ».
- Un message dont la signature Stripe est invalide est rejeté et ne modifie rien.

### US-14 : jamais deux fois le même paiement
**En tant que** membre de la finance, **je veux** qu'un message Stripe reçu deux fois ne soit compté qu'une fois, **afin que** les montants encaissés soient justes.

- Étant donné un événement Stripe déjà traité, quand il est reçu de nouveau, alors aucun nouveau paiement n'est créé et les montants ne changent pas.

### US-15 : alerte sur paiement échoué
**En tant que** commercial, **je veux** être prévenu quand le paiement d'un de mes clients échoue, **afin de** l'appeler avant de lui vendre à nouveau.

- Quand un paiement passe au statut « Échoué », alors une tâche « Relancer le client » est créée pour le propriétaire du compte, avec une échéance à J+2.

---

## Pilotage

### US-17 : tableau de bord du lundi
**En tant que** directrice générale, **je veux** un tableau de bord, **afin de** voir en un coup d'œil où en sont les ventes et les encaissements.

- Il affiche : pipeline par étape, taux de transformation des devis, paiements reçus et échoués, délai moyen de paiement.
- Les données sont à jour à l'ouverture.
