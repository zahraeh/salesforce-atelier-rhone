# Plan : construction et lancement en 1 mois

**Du 5 octobre au 1er novembre 2026 · lancement public le lundi 2 novembre**

D'ici le 1er novembre, un projet Salesforce terminé et public, mené comme une vraie mission client, présentable en entretien en français ou en anglais.

**Terminé au jour 30 signifie :** une org fonctionnelle, ce dépôt GitHub (métadonnées + documents), une démo vidéo de 5 minutes maximum, une étude de cas de 2–3 pages en FR et EN, quatre posts LinkedIn, et une ligne de CV à jour.

**Hypothèses :** 15–20 h par semaine · Developer Edition gratuite · Stripe en mode test · semaines du lundi au dimanche.

## Périmètre

| Domaine | Inclus en v1 | Reporté en v2 |
|---|---|---|
| Modèle de données | Comptes, contacts, opportunités, produits, catalogues de prix, devis, commandes, objet Paiement personnalisé | Stock par entrepôt |
| Sécurité | 3 rôles (Commercial, Responsable commercial, Finance), partage privé, permission sets | Gestion des territoires |
| Automatisation | 2 Flows déclenchés par enregistrement, 1 Screen Flow, 1 processus d'approbation, règles de validation et de doublons | Triggers Apex complexes |
| Intégration 1 | Recherche SIRET via l'API Recherche d'entreprises (Named Credential + callout Apex) | Ré-enrichissement planifié |
| Intégration 2 | Stripe mode test : paiement réussi, échoué, remboursé via webhook, avec idempotence | Synchronisation ERP Odoo |
| Migration | 200 comptes historiques nettoyés et chargés avec ID externe | Commandes historiques |
| Facturation électronique | Conception écrite (2 pages) : Salesforce → ERP → plateforme agréée | Toute construction |
| IA | Conception écrite : rédaction encadrée de réponses support | Construction Agentforce |
| Reporting | Tableau de bord pipeline, paiements, conversion des devis | Prévisions |

**Si je prends du retard, couper dans cet ordre :** note IA → remboursement Stripe → processus d'approbation. **Ne jamais couper les documents ni le lancement.**

## Semaine 1 (5–11 oct.) : cadrage, conception, fondations

- [ ] Brief client (1 page, FR)
- [ ] Note de cadrage : 15–20 questions au client + réponses supposées
- [ ] 15–20 user stories avec critères d'acceptation
- [ ] Modèle de données (Schema Builder ou diagramme) dans le dépôt
- [ ] Journal des décisions démarré
- [ ] Org Developer Edition : objets, champs, SIRET (règle de validation 14 chiffres), TVA intracommunautaire
- [ ] Rôles, OWD, permission sets — tester en se connectant comme chaque utilisateur
- [ ] Dépôt GitHub + SFDX / VS Code pour récupérer les métadonnées
- [ ] **Post LinkedIn 1** (FR) : ce que je construis et pourquoi (le problème client, pas la techno)
- Bonus : champs RGPD sur Contact (date et source du consentement, opt-out)

## Semaine 2 (12–18 oct.) : automatisation, quote-to-cash, première intégration

- [ ] Produits, catalogue de prix en euros, devis avec lignes et conditions de paiement (max 60 jours, LME)
- [ ] Flow : opportunité Gagnée → création de la commande + notification Finance
- [ ] Flow : Paiement « Échoué » → tâche de relance pour le commercial
- [ ] Screen Flow « Nouveau client »
- [ ] Processus d'approbation : remise > 15 % → validation du Responsable commercial
- [ ] Règles de validation et de doublons sur les comptes (SIRET unique)
- [ ] Enrichissement SIRET : Named Credential → recherche-entreprises.api.gouv.fr, classe Apex, bouton ou Flow (raison sociale, adresse, code NAF)
- [ ] Classe de test avec mock (≥ 75 % de couverture)
- [ ] Gestion des erreurs : SIRET invalide, société introuvable, API indisponible — chacune consignée dans le cahier de recette
- [ ] Cahier de recette démarré
- [ ] **Post LinkedIn 2** : enregistrement d'écran de la recherche SIRET
- Bonus : pages Lightning avec Dynamic Forms et Path sur les opportunités

## Semaine 3 (19–25 oct.) : paiements, migration, facturation électronique

**Stripe (mode test)**
- [ ] Callout Apex qui crée un paiement Stripe pour une commande, avec l'ID de commande Salesforce en metadata
- [ ] Endpoint Apex REST public (Salesforce Site) pour les webhooks : réussi, échoué, remboursé
- [ ] Vérifier la signature Stripe en Apex avant tout traitement (justifier dans le journal des décisions)
- [ ] ID d'événement Stripe dans un champ ID externe unique + upsert → un webhook rejoué ne crée jamais de doublon
- [ ] Stripe CLI : déclencher les événements, en rejouer un volontairement, montrer qu'il n'y a pas de doublon (à filmer pour la démo)
- [ ] Prélèvement SEPA en mode test

**Migration**
- [ ] CSV « sale » de 200 comptes : doublons, formats de téléphone mixtes, SIRET manquants, fautes dans les villes
- [ ] Fiche de mapping : colonne source → champ Salesforce → règle de transformation
- [ ] Nettoyage, chargement Data Loader avec `Legacy_ID__c`, réconciliation (entrés / chargés / rejetés)

**Facturation électronique (écrit uniquement)**
- [ ] Vérifier le calendrier actuel de la réforme et le rôle des plateformes agréées (sources officielles : impots.gouv.fr)
- [ ] 2 pages : qui émet la facture, flux commande Salesforce → ERP → plateforme, champs requis (SIREN, TVA, adresse de livraison), questions ouvertes
- [ ] **Post LinkedIn 3** : « Que se passe-t-il quand Stripe envoie deux fois le même paiement ? »

## Semaine 4 (26 oct. – 1er nov.) : reporting, packaging, préparation du lancement

Aucune nouvelle fonctionnalité.

- [ ] Rapports + tableau de bord manager : pipeline par étape, taux de conversion des devis, paiements reçus vs échoués, délai moyen de paiement
- [ ] Cahier de recette terminé : chaque cas exécuté, chaque anomalie clôturée ou documentée
- [ ] Plan de déploiement + runbook d'une page
- [ ] Note de conception IA (1 page)
- [ ] Étude de cas 2–3 pages : FR d'abord, puis EN
- [ ] Démo vidéo (≤ 5 min) présentée au client
- [ ] Nettoyage du dépôt : README FR/EN, métadonnées, `/docs`, captures d'écran
- [ ] CV + section « Sélection » LinkedIn
- [ ] Faire relire le dépôt par 2–3 personnes avant le lancement
- [ ] **Lundi 2 novembre : post 4** avec la vidéo et le lien du dépôt

## Posts LinkedIn

| Post | Quand | Angle | Format |
|---|---|---|---|
| 1 | Semaine 1 | Le problème client et pourquoi je le mène comme une vraie mission | Texte + image du modèle de données |
| 2 | Semaine 2 | Remplir une fiche société à partir d'un SIRET avec une vraie API publique | Vidéo de 30 s |
| 3 | Semaine 3 | Le webhook Stripe reçu deux fois, et ma solution | Texte + schéma simple |
| 4 | 2 nov. | Lancement : ce que j'ai construit, appris, lien dépôt + vidéo | Démo vidéo |

Règles : commencer par le problème métier, pas l'outil · dire ouvertement que c'est un projet personnel · partager une chose qui a mal tourné dans chaque post · #Salesforce #Trailblazer + groupes de la communauté Salesforce française.

## Ligne de CV

**FR :** Projet d'implémentation Salesforce (client fictif, PME industrielle) : cadrage, user stories, modèle de données, sécurité, Flows, intégration API Sirene et Stripe (webhooks, idempotence), migration de 200 comptes, recette, tableau de bord.

**EN :** Salesforce implementation project (fictional industrial SME): discovery, user stories, data model, security, Flows, API integrations (French company register, Stripe webhooks with idempotency), 200-record migration, UAT, dashboards.

## Risques

| Risque | Parade |
|---|---|
| Apex est nouveau, les callouts prennent plus de temps | Time box : 8 h pour SIRET, 12 h pour Stripe. Livrer ce qui marche, documenter le reste en v2. |
| Le webhook Stripe n'atteint pas le Site Salesforce | Tester avec Postman d'abord. Vérifier l'accès de l'utilisateur invité du Site à la classe Apex. |
| La semaine 3 déborde | Décaler la facturation électronique en semaine 4, abandonner la note IA. |
| Le perfectionnisme retarde le lancement | La date est fixe. Une v1 terminée avec une liste v2 claire vaut mieux qu'un projet parfait que personne ne voit. |
| L'org Developer est désactivée | Se connecter au moins une fois par semaine ; toutes les métadonnées dans GitHub. |
| La certification Admin concurrence le temps | Réserver l'examen fin novembre, réviser après le lancement. |

**Point hebdo, chaque dimanche (15 min) :** cocher les tâches, mettre à jour le story log, comparer heures prévues / réelles, décider quoi couper.
