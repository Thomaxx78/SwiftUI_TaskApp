# Gestionnaire Tâches COMPLET SwiftUI

## Description du projet

Ce projet est une application de gestion de tâches développée en SwiftUI. Elle permet aux utilisateurs de se connecter, de créer, modifier et organiser leurs tâches en fonction de leur statut, difficulté et catégorie.

## Fonctionnalités principales

- Authentification utilisateur
- Ajout de nouvelles tâches
- Modification des tâches existantes
- Catégorisation des tâches
- Filtrage des tâches par statut
- Interface utilisateur intuitive et réactive

## Structure du projet

Le projet est organisé en plusieurs fichiers SwiftUI :

- `TaskManagerApp.swift` : Point d'entrée de l'application
- `LoginView.swift` : Vue de connexion
- `ContentView.swift` : Vue principale après connexion
- `TaskListView.swift` : Vue de liste des tâches (non fournie dans les extraits de code)
- `AddTaskView.swift` : Vue pour ajouter une nouvelle tâche
- `EditTaskView.swift` : Vue pour modifier une tâche existante

## Utilisation

### Connexion

Pour vous connecter à l'application, utilisez l'un des comptes suivants :

- Nom d'utilisateur : User1, Mot de passe : password1
- Nom d'utilisateur : user2, Mot de passe : password2

### Gestion des tâches

Une fois connecté, vous pouvez :

- Visualiser vos tâches organisées par statut (À faire, En cours, Terminé)
- Ajouter une nouvelle tâche en spécifiant son titre, sa difficulté et sa catégorie
- Modifier une tâche existante en changeant son titre, son statut, sa difficulté ou sa catégorie
- Supprimer une tâche (fonctionnalité non implémentée dans les extraits fournis)

## Architecture et concepts clés

### Modèles de données

Les principales structures de données utilisées sont :

- `Task` : Représente une tâche avec ses propriétés
- `TaskCategory` : Définit une catégorie de tâche
- `TaskStatus` : Énumération des statuts possibles pour une tâche
- `TaskDifficulty` : Énumération des niveaux de difficulté d'une tâche

### Gestionnaires

Deux classes principales gèrent la logique métier de l'application :

- `AuthManager` : Gère l'authentification des utilisateurs
- `TaskManager` : Gère la création, la modification et la suppression des tâches

## Personnalisation

Vous pouvez personnaliser l'application en modifiant les catégories de tâches dans le `TaskManager`. Actuellement, les catégories prédéfinies sont :

- Travail (bleu)
- Personnel (vert)
- Loisirs (orange)

##Sources

HackingWithSwift : https://www.hackingwithswift.com/
Documentation SwiftUI : https://developer.apple.com/documentation/swiftui/
Stack Overflow : https://stackoverflow.com/




