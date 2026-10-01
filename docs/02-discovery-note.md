# Note de cadrage / Discovery note

*Version 1.0 · 1er octobre 2026 · Réunion de cadrage simulée (projet personnel, client fictif)*

| | |
|---|---|
| **Client** | Atelier Rhône Équipements SAS, Vénissieux (69) |
| **Interlocutrice** | Sophie Marchand, directrice générale |
| **Consultante** | Zahra E. |
| **Format** | Visio, 60 minutes |
| **Objectif** | Comprendre le fonctionnement actuel, les irritants et les critères de succès avant toute conception |

> Toutes les réponses ci-dessous sont des **hypothèses** jouées pour le projet. Dans une vraie mission, chacune serait validée par écrit avec la personne indiquée dans la dernière colonne.

---

## 1. Ce que j'ai retenu en 5 points

1. **Le devis est le point aveugle.** Environ 220 devis par mois sont faits dans un modèle Excel et envoyés en PDF. Personne ne sait combien sont gagnés : la direction estime le taux de transformation entre 25 et 35 %.
2. **Les remises ne sont pas maîtrisées.** Les commerciaux accordent jusqu'à 25 % sans validation. La marge brute a perdu 2 points en 2025.
3. **Les paiements sont relancés à la main, trop tard.** Le délai moyen de paiement (DSO) est de 61 jours pour un objectif de 45. La chargée de recouvrement y passe environ 2 jours par semaine, et les commerciaux continuent de vendre à des clients en retard sans le savoir.
4. **Les fiches clients sont mal renseignées.** Environ 40 % des fiches n'ont pas de SIRET ou ont un SIRET faux, et le fichier contient des doublons. Or la réforme de la facturation électronique exige des identifiants fiables.
5. **La confidentialité des portefeuilles est un sujet sensible.** En 2025, un commercial est parti chez un concurrent avec une copie du fichier clients.

---

## 2. Questions et réponses

| # | Thème | Question posée | Réponse (hypothèse) | Impact sur la conception | À valider avec |
|---|---|---|---|---|---|
| Q01 | Entreprise | Que vendez-vous, et à qui ? | Compresseurs d'air, pompes, matériel de levage et de manutention, pièces détachées. Clients : PME industrielles, BTP et agroalimentaire, en Auvergne-Rhône-Alpes et en Bourgogne. CA 2025 : 23,8 M€. | Catalogue produits et catalogue de prix en euros ; une seule devise. | Sophie Marchand |
| Q02 | Utilisateurs | Qui utilisera l'outil au quotidien ? | 10 commerciaux (7 terrain, 3 sédentaires), 1 directeur commercial, 4 personnes en finance (RAF, 2 comptables, 1 chargée de recouvrement), la DG. Soit 16 utilisateurs. | 3 rôles métier + direction ; licences à chiffrer pour 16 utilisateurs. | Sophie Marchand |
| Q03 | Processus | Racontez-moi une vente, du premier contact au paiement. | Appel ou salon → le commercial crée le client dans Excel → devis Excel envoyé en PDF → relances « quand il y pense » → bon de commande signé par email → l'ADV ressaisit la commande dans le logiciel de gestion → facture → paiement → relance par la finance si retard. | Processus cible : Compte → Opportunité → Devis → Commande → Paiement, dans un seul outil. | Karim Benali (dir. commercial) |
| Q04 | Devis | Combien de devis par mois, et combien sont gagnés ? | Environ 220 par mois. Taux de transformation inconnu ; estimé entre 25 et 35 %. Aucun suivi des devis expirés. | Devis Salesforce liés aux opportunités ; rapport de taux de transformation. | Karim Benali |
| Q05 | Remises | Qui décide d'une remise ? | Le commercial, jusqu'à 25 %, sans validation. Le directeur commercial le découvre parfois sur la facture. | Processus d'approbation au-delà de 15 %. | Karim Benali |
| Q06 | Paiement | Comment vos clients paient-ils ? | 70 % virement à 45 jours fin de mois, 20 % LCR, 10 % carte ou chèque (pièces détachées au comptoir). | Champ « conditions de paiement » sur les devis ; conformité LME (60 jours max). | Hélène Roux (RAF) |
| Q07 | Paiement | Qu'aimeriez-vous changer dans les paiements ? | Proposer un lien de paiement en ligne (carte et prélèvement SEPA) pour les petites commandes de pièces détachées, sous 2 000 €. | Intégration Stripe (mode test) ; objet Paiement. | Hélène Roux |
| Q08 | Recouvrement | Comment savez-vous qu'un client paie en retard ? | Extraction mensuelle de la comptabilité, mise en forme dans Excel par la chargée de recouvrement. Les commerciaux ne sont pas prévenus. | Flow : paiement échoué → tâche de relance pour le commercial du compte. | Hélène Roux |
| Q09 | Données | Combien de clients, et dans quel état est le fichier ? | Fichier Excel d'environ 2 300 lignes, dont environ 1 450 clients actifs. Doublons, téléphones dans tous les formats, SIRET manquants ou faux sur environ 40 % des lignes. | Migration avec nettoyage, ID externe `Legacy_ID__c`, règle de doublons sur le SIRET. Échantillon v1 : 200 comptes. | Hélène Roux |
| Q10 | Données | Qui saisit les informations d'un nouveau client ? | Le commercial, à la main : raison sociale, adresse, SIRET. Il faut environ 10 minutes par fiche, avec des erreurs. | Enrichissement automatique depuis l'API Recherche d'entreprises à partir du SIRET. | Karim Benali |
| Q11 | Sécurité | Un commercial doit-il voir les clients d'un collègue ? | Non. Depuis le départ d'un commercial chez un concurrent en 2025 avec le fichier, c'est non négociable. Le directeur commercial voit tout, la finance voit tout en lecture. | Partage privé sur les comptes ; hiérarchie de rôles ; règle de partage en lecture pour la finance. | Sophie Marchand |
| Q12 | Sécurité | Que doit pouvoir modifier la finance ? | Les paiements uniquement. Elle ne doit pas modifier les devis ni les opportunités. | Permission set Finance : lecture sur les ventes, création et modification sur les paiements. | Hélène Roux |
| Q13 | Facturation | Qui émet les factures aujourd'hui, et demain ? | Le logiciel de gestion commerciale et comptable. Un ERP (Odoo est envisagé) est prévu pour 2027. Salesforce ne doit pas facturer. | Salesforce s'arrête à la commande et au suivi de paiement ; la facture reste dans l'ERP. | Hélène Roux |
| Q14 | Facturation électronique | Où en êtes-vous sur la réforme ? | « Notre expert-comptable dit qu'on doit pouvoir recevoir des factures électroniques depuis septembre, et en émettre l'an prochain. On n'a pas choisi de plateforme. » | Fiabiliser SIREN, n° de TVA et adresses dès la v1 ; note de conception en semaine 3. | Expert-comptable |
| Q15 | Intégrations | Quels outils doivent échanger avec Salesforce ? | Le logiciel comptable (export manuel aujourd'hui), plus tard l'ERP. Pas d'outil d'emailing. | v1 : pas d'intégration comptable ; Stripe et API SIRET uniquement. Synchronisation ERP en v2. | Hélène Roux |
| Q16 | RGPD | Comment gérez-vous le consentement des contacts ? | Une newsletter trimestrielle part à tous les contacts du fichier. Aucune trace du consentement. | Champs consentement (date, source, opposition) sur Contact. | Sophie Marchand |
| Q17 | Reporting | Quel chiffre regardez-vous chaque lundi ? | « Aucun, et c'est le problème. » Elle voudrait le pipeline, les devis en attente et les impayés. | Tableau de bord manager : pipeline, conversion des devis, paiements reçus vs échoués, délai moyen de paiement. | Sophie Marchand |
| Q18 | Succès | Dans 6 mois, qu'est-ce qui vous ferait dire que c'est réussi ? | DSO ramené à 50 jours ; taux de transformation connu ; aucune remise au-delà de 15 % sans accord ; une fiche client créée en moins de 2 minutes. | Critères d'acceptation et indicateurs du tableau de bord. | Sophie Marchand |
| Q19 | Planning | Avez-vous une date en tête ? | Première version utilisable avant la fin de l'année, sans perturber la clôture comptable. | Périmètre v1 resserré ; liste v2 explicite. | Sophie Marchand |
| Q20 | Conduite du changement | Qui risque de résister ? | Les commerciaux terrain les plus anciens : « Ils vont dire que c'est du flicage. » | Saisie mobile simple ; Screen Flow « Nouveau client » ; montrer ce que l'outil leur fait gagner. | Karim Benali |

---

## 3. Questions ouvertes

| # | Question | Pourquoi c'est important | Responsable |
|---|---|---|---|
| O1 | Faut-il reprendre les clients inactifs depuis plus de 3 ans ? | Volume et qualité de la migration ; RGPD (durée de conservation). | Hélène Roux |
| O2 | Quelles conditions de paiement exactes sont proposées aux clients ? | Liste de valeurs sur les devis ; conformité LME. | Hélène Roux |
| O3 | Quelle plateforme agréée pour la facturation électronique ? | Détermine le flux de la note de conception (semaine 3). | Expert-comptable |
| O4 | Un compte peut-il changer de commercial, et qui décide ? | Règles de transfert de propriété et de partage. | Karim Benali |
| O5 | Le directeur commercial doit-il valider toutes les remises au-delà de 15 %, ou seulement au-delà d'un montant ? | Critères d'entrée du processus d'approbation. | Karim Benali |

## 4. Prochaines étapes

1. Envoyer ce compte rendu à Sophie Marchand pour validation.
2. Rédiger le brief client et les user stories à partir de cette note.
3. Organiser deux ateliers courts : ventes (Karim Benali) et finance (Hélène Roux), pour valider les hypothèses marquées.
