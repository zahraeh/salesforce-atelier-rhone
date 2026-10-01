# Story log

*Une ligne le jour même, chaque fois que quelque chose casse ou prend plus de temps que prévu.*

| Date | Ce qui a mal tourné | Ce que j'ai fait | Résultat | Heures estimées / réelles |
|---|---|---|---|---|
| 01/10/2026 | La connexion de l'org au CLI a expiré deux fois | Relancé la connexion en vérifiant les journaux du CLI : le navigateur s'ouvrait bien, la page n'était pas vue à temps | Connecté à la 3e tentative | 0,25 / 1 |
| 01/10/2026 | Le passage en partage privé des comptes a échoué : les requêtes (Case) étaient plus ouvertes que les comptes | Passé les requêtes en privé aussi (D-13) | Déployé | — |
| 01/10/2026 | Les rôles ont été refusés juste après le passage en privé (« accès en dessous du défaut de l'organisation ») | Compris que le changement de partage est appliqué en arrière-plan ; attendu la fin du recalcul, puis redéployé | Rôles créés | — |
| 01/10/2026 | Les permission sets ont été refusés : on ne peut pas donner de droits sur un champ obligatoire | Retiré `Status__c` et `Amount__c` des permission sets : les champs obligatoires sont toujours visibles | Déployé | — |
| 01/10/2026 | La règle de partage Finance ne pouvait pas partir de « Tous les utilisateurs internes » | Basée sur la hiérarchie des rôles ; noté la conséquence dans le runbook (D-14) | Déployé | — |
| 01/10/2026 | L'org gratuite n'a qu'une licence Salesforce libre pour 4 personnages | Utilisateurs de test adaptés aux licences ; limite documentée (D-11, DEF-01) | Sécurité testée sur 3 utilisateurs | — |

## Point hebdo

| Semaine | Heures prévues | Heures réelles | Tâches terminées | Ce que je coupe |
|---|---:|---:|---|---|
| S1 (5–11 oct.) | 15–20 | | | |
| S2 (12–18 oct.) | 15–20 | | | |
| S3 (19–25 oct.) | 15–20 | | | |
| S4 (26 oct. – 1 nov.) | 15–20 | | | |
