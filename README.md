# Atelier Rhône Équipements — Implémentation Salesforce

🇫🇷 [Français](#français) · 🇬🇧 [English](#english)

> 🚧 **En construction : lancement le 2 novembre 2026.** Ce dépôt est construit en public, semaine par semaine.
> 🚧 **Work in progress: launching 2 November 2026.** This repo is built in public, week by week.

📄 **Case study:** [zahra-work.com/salesforce-implementation.html](https://zahra-work.com/salesforce-implementation.html)

---

## Français

Projet d'implémentation Salesforce mené comme une vraie mission client, de la phase de cadrage au tableau de bord.

> **Client :** Atelier Rhône Équipements, distributeur lyonnais d'équipements industriels (~80 salariés), client **fictif**.
> Il quitte Excel et un petit outil comptable pour Salesforce. Aujourd'hui, l'entreprise perd la trace de ses devis, relance les paiements à la main, ressaisit les informations des sociétés et doit se préparer à la réforme de la facturation électronique.

**Périmètre v1 :** modèle de données (comptes, contacts, opportunités, produits, devis, commandes, objet Paiement), sécurité (3 rôles, partage privé), Flows et processus d'approbation, enrichissement SIRET (API Recherche d'entreprises), paiements Stripe en mode test (webhooks idempotents), migration de 200 comptes, conception facturation électronique, tableau de bord.

## English

A Salesforce implementation run like a real client engagement, from discovery to dashboard.

> **Client:** Atelier Rhône Équipements, a **fictional** Lyon-based industrial equipment distributor (~80 staff), moving from Excel and a small accounting tool to Salesforce.
> They lose track of quotes, chase payments by hand, re-type company details, and need to prepare for the French e-invoicing reform.

**v1 scope:** data model (accounts, contacts, opportunities, products, quotes, orders, custom Payment object), security (3 roles, private sharing), Flows and an approval process, SIRET enrichment (French government company API), Stripe test-mode payments (idempotent webhooks), 200-account migration, e-invoicing design, dashboard.

---

## Livrables / Deliverables

| # | Document | Semaine / Week | Statut / Status |
|---|---|:---:|:---:|
| 00 | [Plan du projet / Project plan](docs/00-plan.md) | 0 | ✅ |
| 01 | [Brief client (FR)](docs/01-brief-client.md) | 1 | ⬜ |
| 02 | [Note de cadrage / Discovery note](docs/02-discovery-note.md) | 1 | ⬜ |
| 03 | [User stories](docs/03-user-stories.md) | 1 | ⬜ |
| 04 | [Modèle de données / Data model](docs/04-data-model.md) | 1 | ⬜ |
| 05 | [Journal des décisions / Decision log](docs/05-decision-log.md) | 1 → 4 | ⬜ |
| 06 | [Mapping de données / Data mapping](docs/06-data-mapping.md) | 3 | ⬜ |
| 07 | [Cahier de recette / UAT workbook](docs/07-uat-workbook.md) | 2 → 4 | ⬜ |
| 08 | [Facturation électronique / E-invoicing design](docs/08-e-invoicing-design.md) | 3 | ⬜ |
| 09 | [Note de conception IA / AI design note](docs/09-ai-design-note.md) | 4 | ⬜ |
| 10 | [Plan de déploiement & runbook](docs/10-deployment-plan-runbook.md) | 4 | ⬜ |
| 11 | [Étude de cas (FR)](docs/11-etude-de-cas-fr.md) | 4 | ⬜ |
| 12 | [Case study (EN)](docs/12-case-study-en.md) | 4 | ⬜ |
| — | [Story log](docs/story-log.md) | 1 → 4 | ⬜ |
| — | Démo vidéo / Demo video (≤ 5 min) | 4 | ⬜ |

## Structure

```
force-app/main/default/   Métadonnées Salesforce (objets, Apex, Flows, permission sets…)
manifest/package.xml      Manifest pour récupérer les métadonnées de l'org
docs/                     Tous les livrables client / all client deliverables
data/legacy/              CSV « sale » des 200 comptes historiques (généré, fictif)
data/clean/               CSV nettoyé, prêt pour Data Loader
scripts/                  Scripts de nettoyage et de génération de données
```

## Récupérer les métadonnées / Pull metadata

```bash
sf org login web --alias atelier-rhone
sf project retrieve start --manifest manifest/package.xml --target-org atelier-rhone
```

## Avertissement / Disclaimer

Projet personnel d'apprentissage. Le client, ses salariés et toutes les données sont fictifs. Stripe est utilisé exclusivement en mode test.
Self-directed learning project. The client, its staff and all data are fictional. Stripe runs in test mode only.
