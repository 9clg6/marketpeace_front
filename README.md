# MarketPeace App
**Créateur**: Clément GUYON
**Ecole**: Ynov Lyon Campus
**Formation**: Mastère Développement Logiciel, Mobile & IoT
**Module**: Web Service
**Groupe**: Travail réalisé **SEUL**.

MarketPeace est une application de type MarketPlace développée en **Flutter 3.0** permettant aux utilisateurs de créer des annonces de produits d'occasions.

## Application Back

L'application Web (API) est disponible sur [ce GitHub](https://github.com/ClementG63/marketpeace_back).

## Pré-requis

Afin de pouvoir faire fonctionner l'application correctement il faut :

#### Pour compiler :

 1. Avoir une installation **fonctionnelle** de **Flutter 3.0**. [compilation]
 2. Avoir un IDE configuré pour Flutter, de *préférence* **Android Studio**.

#### Avant l'exécution :
❌ Sans ces pré-requis vous ne pourrez pas récupérer les annonces depuis la base de données.

 1. Assurez vous que l'ordinateur depuis lequel vous compilez ainsi que l'appareil cible **soient connectés sur le même réseau** (par exemple: compilation depuis votre ordinateur sur un appareil mobile, même réseau nécessaire).

 2. Avoir la base de données MySQL **en cours d'exécution** avec l'export fourni.
 
 4. Avoir l'API **en cours d'exécution**, de préférence sur **IntelliJ**.

#### Modification à effectuer sur le code  :
❌ Sans ces pré-requis vous ne pourrez pas communiquer avec l'API.

*Modification à effectuer si la cible de la compilation est un téléphone ou une tablette.*

Ouvrez le fichier :

    lib/constants.dart

Puis insérez votre **adresse IP** à la place de la **valeur** de la constante nommée :

    apiAddress

Ce qui donnera *après vos modification* :

    const apiAddress = 'http://[VOTRE_IP]:8080';

 ⚠️ Si vous compilez depuis votre ordinateur sur la version **Flutter Web** (cible: Chrome, Edge etc.), vous pouvez mettre **127.0.0.1** ⚠️ 

## Fonctionnalités

 - [x] Création de compte
 - [x] Connexion
 - [x] Déconnexion
 - [x] Expiration de connexion
 - [x] Création d'une annonce (formulaire dynamique + prise de photo dans le formulaire + affichage de la photo + hébergement de la photo sur Firebase Cloud Storage)
 - [x] Récupération de la liste des annonces
 - [x] Récupération de la liste des annonces créées par le profil connecté
 - [ ] Recherche d'une annonce
 - [ ] **Interface** de suppression d'une annonce (fonctionnelle sur l'API)
 - [ ] **Interface** de mise à jour d'une annonce (fonctionnelle sur l'API)
 - [ ] Interface des détails d'une annonce (fonctionnelle sur l'API [*cf. findAdById*])

## Tests

### Connexion

Si vous ne souhaitez pas créer de compte ou simplement accéder à l'application depuis un compte déjà créé (et ADMIN), vous pouvez utiliser les identifiants suivants :

**Username**: ADMIN
    
**Password**:  ADMIN123456789
    
⚠️ Vous pouvez accéder à la page de connexion en cliquant sur le petit bouton rouge contenant un personnage blanc à droite de la barre de recherche sur l'écran d'accueil.

### Inscription

Si vous souhaitez vous créer un compte il suffit de remplir le formulaire.
Les seules informations **obligatoires** sont :

 - **Pseudo**
 - **Adresse mail**
 - **Mot de passe (+confirmation)**

⚠️ Vous pouvez accéder à la page d'inscription en cliquant sur le texte noir "S'inscrire" en haut à droite de l'écran de connexion.
