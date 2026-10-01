# Brief client : Atelier Rhône Équipements

*Version 1.0 · 1er octobre 2026 · Source : [note de cadrage](02-discovery-note.md) · Client fictif*

## Qui est le client

Atelier Rhône Équipements est une SAS de Vénissieux (69), créée en 1996, qui distribue du matériel industriel : compresseurs d'air, pompes, matériel de levage et de manutention, et pièces détachées. Elle emploie 82 personnes et a réalisé 23,8 M€ de chiffre d'affaires en 2025. Ses clients sont des PME industrielles, du BTP et de l'agroalimentaire en Auvergne-Rhône-Alpes et en Bourgogne.

## Situation actuelle

Les ventes reposent sur Excel. Les clients sont dans un fichier partagé, les devis sont faits dans un modèle Excel et envoyés en PDF. Les commandes sont ressaisies dans un logiciel de gestion commerciale et comptable, qui émet les factures. Le suivi des retards de paiement se fait dans Excel, à partir d'une extraction mensuelle.

## Problèmes

| Problème | Ce que ça coûte aujourd'hui |
|---|---|
| **Les devis sont perdus de vue** | Environ 220 devis par mois, sans suivi : personne ne connaît le taux de transformation (estimé entre 25 et 35 %). |
| **Les remises ne sont pas maîtrisées** | Remises jusqu'à 25 % sans validation ; la marge brute a perdu 2 points en 2025. |
| **Les paiements sont relancés à la main** | Délai moyen de paiement de 61 jours (objectif : 45) ; environ 2 jours par semaine de relances ; les commerciaux ne savent pas quels clients sont en retard. |
| **Les fiches clients sont ressaisies et peu fiables** | Environ 10 minutes par nouvelle fiche ; environ 40 % des fiches sans SIRET valide ; doublons. |
| **La réforme de la facturation électronique approche** | Elle exige des SIREN, numéros de TVA et adresses fiables, que l'entreprise n'a pas aujourd'hui. |
| **Les portefeuilles clients ne sont pas protégés** | En 2025, un commercial est parti chez un concurrent avec une copie du fichier clients. |

## Objectifs à 6 mois

1. Ramener le délai moyen de paiement de **61 à 50 jours**.
2. **Connaître le taux de transformation** des devis, chaque semaine.
3. **Aucune remise au-delà de 15 %** sans l'accord du directeur commercial.
4. Créer une fiche client complète **en moins de 2 minutes**.
5. Disposer de données clients **prêtes pour la facturation électronique**.

## Périmètre de la v1

| Inclus | Reporté en v2 |
|---|---|
| Comptes, contacts, opportunités, produits, devis, commandes, paiements | Stock par entrepôt |
| 3 rôles métier, partage privé des comptes | Gestion des territoires |
| Automatisations : commande à la signature, relance sur paiement échoué, fiche « Nouveau client », approbation des remises | Automatisations Apex complexes |
| Enrichissement des fiches à partir du SIRET | Ré-enrichissement planifié |
| Paiement en ligne Stripe (mode test) | Synchronisation avec l'ERP |
| Reprise d'un échantillon de 200 comptes nettoyés | Reprise de l'historique des commandes |
| Note de conception facturation électronique | Toute réalisation |
| Tableau de bord de direction | Prévisions des ventes |

Salesforce ne facture pas : la facture reste émise par le logiciel comptable, puis par l'ERP.

## Parties prenantes

| Rôle | Nom (fictif) | Attentes |
|---|---|---|
| Directrice générale, sponsor | Sophie Marchand | Visibilité chaque lundi : pipeline, devis en attente, impayés |
| Directeur commercial | Karim Benali | Valider les remises, suivre son équipe sans ressaisie |
| Responsable administrative et financière | Hélène Roux | Moins de relances manuelles, données prêtes pour la réforme |
| Commerciaux (10) | — | Un outil simple qui ne leur fait pas perdre de temps |

## Calendrier

Construction du 5 octobre au 1er novembre 2026 ; présentation de la v1 le 2 novembre.
