# 📋 Projet Dart CLI — Gestionnaire de tâches

> **Objectif :** Construire une application CLI en **Dart pur** permettant de gérer des tâches tout en appliquant les concepts de la programmation orientée objet (POO), la persistance des données en JSON et les tests unitaires.

---

# ✅ Checklist des tâches

---

## 🏗️ Tâche 1 — Initialiser le projet

### 🎯 Objectif

Créer le projet Dart et préparer toute l'architecture du projet.

### À faire

- [ ] Créer le projet Dart CLI
- [ ] Organiser les dossiers
- [ ] Créer les fichiers de base
- [ ] Vérifier que le projet compile

### 📤 Résultat attendu

Aucun retour particulier.

Le projet doit simplement être fonctionnel.

### 💡 Pistes

- dart create
- bin/
- lib/
- test/
- pubspec.yaml

---

# 📦 Partie Modèle (Models)

---

## 📝 Tâche 2 — Créer le modèle Task

### 🎯 Objectif

Créer la classe représentant une tâche.

### La tâche devra contenir

- [ ] un identifiant
- [ ] un titre
- [ ] une priorité
- [ ] une date limite (optionnelle)
- [ ] un état (terminée ou non)

### 📤 Return attendu

```dart
Task
```

### 💡 Pistes

- class
- constructeur
- attributs
- DateTime
- nullable

---

## 📝 Tâche 3 — Transformer Task en classe abstraite

### 🎯 Objectif

Empêcher l'instanciation directe de Task.

### À faire

- [ ] déclarer Task comme abstraite
- [ ] ajouter une méthode abstraite

### 📤 Return attendu

Classe abstraite.

### 💡 Pistes

- abstract class
- méthode abstraite
- héritage

---

## 🚨 Tâche 4 — Créer UrgentTask

### 🎯 Objectif

Créer une classe qui hérite de Task.

### À faire

- [ ] hériter de Task
- [ ] personnaliser un comportement

### 📤 Return attendu

```dart
UrgentTask
```

### 💡 Pistes

- extends
- override
- super

---

# 📚 Partie Enum

---

## 🔥 Tâche 5 — Créer Priority

### 🎯 Objectif

Créer un enum représentant les niveaux de priorité.

### Valeurs

- [ ] low
- [ ] medium
- [ ] high

### 📤 Return attendu

```dart
Priority.low
Priority.medium
Priority.high
```

### 💡 Pistes

- enum
- switch
- compare

---

# 🔌 Partie Interface

---

## 🧩 Tâche 6 — Créer une interface

### 🎯 Objectif

Forcer les modèles à savoir se convertir en JSON.

### À faire

Créer une interface.

Exemple de responsabilité :

- [ ] convertir un objet vers JSON

### 📤 Return attendu

```dart
Map<String, dynamic>
```

### 💡 Pistes

- abstract interface
- implements
- méthode obligatoire

---

# 🔄 Partie JSON

---

## 📄 Tâche 7 — Implémenter la conversion JSON

### 🎯 Objectif

Permettre :

- [ ] Task → JSON
- [ ] JSON → Task

### 📤 Return attendu

Vers JSON

```dart
Map<String, dynamic>
```

Depuis JSON

```dart
Task
```

### 💡 Pistes

- toJson()
- fromJson()
- jsonEncode()
- jsonDecode()

---

# 📦 Partie Repository

---

## 🗂️ Tâche 8 — Créer Repository<T>

### 🎯 Objectif

Créer un repository générique.

### À faire

Définir les opérations CRUD génériques.

### 📤 Return attendu

```dart
T
```

ou

```dart
List<T>
```

### 💡 Pistes

- Generic
- Repository<T>
- CRUD

---

## 📂 Tâche 9 — Créer TaskRepository

### 🎯 Objectif

Créer le repository spécialisé pour les tâches.

### Responsabilités

- [ ] ajouter
- [ ] lire
- [ ] supprimer
- [ ] sauvegarder

### 📤 Return attendu

Ajouter

```dart
void
```

Lister

```dart
List<Task>
```

Supprimer

```dart
void
```

### 💡 Pistes

- extends
- override
- stockage

---

# 💾 Partie Persistance

---

## 📖 Tâche 10 — Lire le fichier JSON

### 🎯 Objectif

Charger toutes les tâches depuis le disque.

### À faire

- [ ] vérifier si le fichier existe
- [ ] lire son contenu
- [ ] convertir le JSON en objets

### 📤 Return attendu

```dart
List<Task>
```

### 💡 Pistes

- File
- readAsString()
- exists()

---

## 💿 Tâche 11 — Sauvegarder dans JSON

### 🎯 Objectif

Enregistrer les tâches.

### À faire

- [ ] convertir la liste en JSON
- [ ] écrire dans le fichier

### 📤 Return attendu

```dart
Future<void>
```

ou

```dart
void
```

### 💡 Pistes

- writeAsString()
- jsonEncode()

---

# ⚙️ Partie Service

---

## 🧠 Tâche 12 — Créer TaskService

### 🎯 Objectif

Centraliser toute la logique métier.

### Le service devra gérer

- [ ] ajouter
- [ ] supprimer
- [ ] terminer
- [ ] lister
- [ ] trier
- [ ] sauvegarder

### 📤 Return attendu

Ajouter

```dart
void
```

Lister

```dart
List<Task>
```

Supprimer

```dart
void
```

Terminer

```dart
void
```

### 💡 Pistes

- Service Layer
- Composition
- Repository

---

# ✨ Fonctionnalités

---

## ➕ Tâche 13 — Ajouter une tâche

### 🎯 Objectif

Créer une nouvelle tâche.

### Étapes

- [ ] récupérer les informations
- [ ] créer l'objet
- [ ] sauvegarder

### 📤 Return attendu

```dart
void
```

ou

```dart
Task
```

### 💡 Pistes

- constructeur
- validation
- repository

---

## 📋 Tâche 14 — Lister les tâches

### 🎯 Objectif

Afficher toutes les tâches.

### 📤 Return attendu

```dart
List<Task>
```

### 💡 Pistes

- for
- print
- map

---

## 📊 Tâche 15 — Trier par priorité

### 🎯 Objectif

Afficher :

High

↓

Medium

↓

Low

### 📤 Return attendu

```dart
List<Task>
```

### 💡 Pistes

- sort()
- Comparator
- enum

---

## 📅 Tâche 16 — Trier par date

### 🎯 Objectif

Afficher les tâches par ordre chronologique.

### 📤 Return attendu

```dart
List<Task>
```

### 💡 Pistes

- DateTime.compareTo()
- sort()

---

## ✅ Tâche 17 — Marquer une tâche terminée

### 🎯 Objectif

Modifier uniquement son état.

### 📤 Return attendu

```dart
void
```

### 💡 Pistes

- bool
- update
- recherche

---

## 🗑️ Tâche 18 — Supprimer une tâche

### 🎯 Objectif

Retirer définitivement une tâche.

### 📤 Return attendu

```dart
void
```

### 💡 Pistes

- removeWhere()
- id

---

# 🚨 Gestion des erreurs

---

## ⚠️ Tâche 19 — Créer des exceptions personnalisées

### 🎯 Objectif

Créer des erreurs spécifiques.

Exemples

- [ ] TaskNotFoundException
- [ ] InvalidPriorityException
- [ ] StorageException

### 📤 Return attendu

Une exception levée.

### 💡 Pistes

- Exception
- throw

---

## 🛡️ Tâche 20 — Gérer les erreurs

### 🎯 Objectif

Empêcher le programme de planter.

### À faire

- [ ] utiliser try
- [ ] utiliser catch
- [ ] afficher un message clair

### 📤 Return attendu

Selon le contexte.

### 💡 Pistes

- try
- catch
- finally

---

# 💻 Interface CLI

---

## 🖥️ Tâche 21 — Créer le menu CLI

### 🎯 Objectif

Permettre à l'utilisateur d'utiliser l'application.

### Le menu devra proposer

- [ ] Ajouter
- [ ] Lister
- [ ] Trier
- [ ] Terminer
- [ ] Supprimer
- [ ] Quitter

### 📤 Return attendu

Affichage dans le terminal.

### 💡 Pistes

- stdin
- stdout
- switch
- while

---

## 🔗 Tâche 22 — Connecter toute l'application

### 🎯 Objectif

Faire communiquer toutes les couches.

```text
Utilisateur

↓

CLI

↓

TaskService

↓

TaskRepository

↓

tasks.json
```

### 📤 Return attendu

Application entièrement fonctionnelle.

### 💡 Pistes

- import
- dépendances
- architecture

---

# 🧪 Tests unitaires

---

## 🧪 Tâche 23 — Écrire au moins 5 tests

### Test 1

Ajouter une tâche.

**Return attendu**

```dart
Task ajoutée
```

---

### Test 2

Supprimer une tâche.

**Return attendu**

```dart
La tâche n'existe plus.
```

---

### Test 3

Marquer une tâche terminée.

**Return attendu**

```dart
completed == true
```

---

### Test 4

Conversion JSON.

**Return attendu**

```dart
Task → JSON → Task
```

Les données doivent être identiques.

---

### Test 5

Exception personnalisée.

**Return attendu**

```dart
throw TaskNotFoundException
```

### 💡 Pistes

- package:test
- expect()
- group()
- throwsException()

---

# ✅ Vérification finale

Avant de rendre le projet, vérifier que toutes les exigences sont satisfaites.

| Fonctionnalité | État |
|---------------|------|
| Ajouter une tâche | ⬜ |
| Lister les tâches | ⬜ |
| Trier par priorité | ⬜ |
| Trier par date | ⬜ |
| Marquer terminée | ⬜ |
| Supprimer | ⬜ |
| Persistance JSON | ⬜ |
| Lecture JSON | ⬜ |
| Classe abstraite | ⬜ |
| Héritage | ⬜ |
| Interface | ⬜ |
| Génériques | ⬜ |
| Exceptions personnalisées | ⬜ |
| 5 tests unitaires minimum | ⬜ |

---

# 🎯 Objectif final

À la fin du projet, tu devras avoir une application CLI capable de :

- ✅ Ajouter une tâche
- ✅ Lister les tâches
- ✅ Trier les tâches
- ✅ Marquer une tâche comme terminée
- ✅ Supprimer une tâche
- ✅ Sauvegarder automatiquement les données dans un fichier JSON
- ✅ Recharger les données au prochain lancement de l'application
- ✅ Respecter toutes les contraintes de POO demandées (classe abstraite, héritage, interface, génériques et exceptions)
- ✅ Posséder une suite de tests unitaires validant les fonctionnalités principales