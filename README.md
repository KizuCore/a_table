# FrigoApp V.0

FrigoApp est une application mobile Flutter permettant de gérer facilement le contenu de son réfrigérateur et de suivre les dates de péremption des aliments.  
L’objectif est de réduire le gaspillage alimentaire grâce à une interface simple et des notifications efficaces.

---

## Sommaire

- [Fonctionnalités](#fonctionnalités)  
- [Architecture](#architecture)  
- [Technologies](#technologies)  
- [Installation](#installation)  
- [Tests](#tests)  
- [Structure du projet](#structure-du-projet)  
- [Contributeurs](#contributeurs)  

---

## Fonctionnalités

- Gestion de l’inventaire des aliments (ajout, suppression, tri)  
- Suivi des dates de péremption avec affichage par statut : OK, bientôt périmé, expiré  
- Vue calendrier pour visualiser les échéances par jour  
- Segmentation par emplacement (frigo, congélateur, placard)  
- Interface moderne basée sur Material 3  
- Base de données locale rapide (Isar)  
- Prêt pour la mise en place future de notifications et de recettes liées

---

## Architecture

Le projet est structuré en plusieurs couches :

- **Présentation (UI)** : pages Flutter et widgets réactifs  
- **Domaine** : entités et logique métier  
- **Données** : repositories et accès à la base locale  
- **Core** : services partagés (base de données, utilitaires)  
- **Shared** : widgets et helpers réutilisables

La base de données locale utilise **Isar** en mode “offline-first”, avec un StreamProvider Riverpod pour actualiser la vue en temps réel.

---

## Technologies

- **Flutter 3.x**  
- **Dart**  
- **Riverpod** pour la gestion d’état  
- **Isar 4** pour la base locale  
- **GoRouter** pour la navigation  
- **TableCalendar** pour la vue calendrier  
- **Google Fonts / Material 3** pour l’interface

---

## Installation

1. **Cloner le dépôt**
   ```bash
   git clone https://github.com/ton-utilisateur/frigo-app.git
   cd frigo-app
   ```

2. **Installer les dépendances**
   ```bash
   flutter pub get
   ```

3. **Générer les fichiers Isar**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. **Lancer l’application**
   ```bash
   flutter run
   ```

---

## Tests

Pour exécuter les tests unitaires et widgets :
```bash
flutter test
```

---

## Structure du projet

```
lib/
 ├─ app/              → theming, routing, localisation
 ├─ core/             → services (Isar, utils)
 ├─ features/
 │   ├─ inventory/    → gestion des aliments
 │   ├─ calendar/     → calendrier et notifications
 │   └─ categories/   → catégories d’aliments
 ├─ shared/           → widgets réutilisables
 └─ main.dart
```

---

## Contributeurs

- **KizuCore** — Développeur principal
