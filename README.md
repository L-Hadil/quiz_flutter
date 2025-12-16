Flutter Quiz Advanced est une application mobile de quiz complète qui démontre l'utilisation de multiples patterns de gestion d'état. L'application permet aux utilisateurs de répondre à des questions, suivre leurs scores et améliorer leurs connaissances de manière interactive. 

## Fonctionnalités

- Quiz interactif avec questions à choix multiples
- Suivi des scores et statistiques
- Sauvegarde locale des progrès avec SharedPreferences
- Interface utilisateur moderne et intuitive
- Gestion d'état avec Provider et BLoC
- Support multi-plateforme (Android, iOS, Web, Linux)

## Architecture

Le projet suit une architecture Clean Architecture avec séparation des responsabilités : 

```
lib/
├── business_logic/    # Logique métier (BLoC, Providers)
├── core/             # Utilitaires et constantes
├── data/             # Modèles et sources de données
├── presentation/     # Interfaces utilisateur (Screens, Widgets)
└── main.dart         # Point d'entrée de l'application
```

### Firebase (To Be Continued)

**Status :** En développement

## Installation

### Prérequis
- Flutter SDK 3.0.0 ou supérieur
- Dart SDK 3.0.0 ou supérieur

### Étapes d'installation

1. **Cloner le repository**
```bash
git clone https://github.com/L-Hadil/quiz_flutter.git
cd quiz_flutter
```

2. **Installer les dépendances**
```bash
flutter pub get
```

3. **Lancer l'application**
```bash
flutter run
```

## Utilisation

### Lancer sur différentes plateformes

**Android/iOS :**
```bash
flutter run
```

**Web :**
```bash
flutter run -d chrome
```

**Linux :**
```bash
flutter run -d linux
```

## Plateformes Supportées

- Android
- iOS
- Web
- Linux

