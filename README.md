# SAE Mobile

LUDMANN Dorian
MASSUARD Charles

## Présentation du projet

Pour cette SAE, nous avons du réaliser une application en flutter. Cette application propose aux utilisateurs de créer des annonces, afin de chercher un objet. Les utilisateurs peuvent répondre aux annonces avec les objets qu'ils ont importés dans leur profil.

## Fonctionnalités réalisées

- Création d'un compte, avec le mail et un mot de passe
- Création d'une annonce : Titre, description et dates.
- L'utilisateur peut voir les annonces qu'il a crée, ainsi que si il a ou non reçu des réponses.
- Visualisation des annonces sur la page d'accueil. Les annonces sont affichées de la plus récente à la plus ancienne.
- Visualisation plus complète d'une annonce en cliquant dessus. 
- Un utilisateur peut répondre à une annonce, en séléctionnant dans un menu déroulant l'objet qu'il souhaite préter.
- Un utilisateur peut voir les réponses à son ou ses annonces, et accepter ou non la proposition.
- L'utilisateur peut voir ses prets et ses emprunts en cours.
- L'utilisateur peut voir les objets qu'il a importé dans son profil.
- L'utilisateur peut ajouter un objet à son profil (titre, description), et le supprimer.
- Le demandeur et le preteur peuvent noter le prêt comme étant terminé.
- Le demandeur peut donner un avis sur l'objet qu'il a emprunté, et/ou sur l'utilisateur qui lui a prété l'objet.
- Le preteur peut donner un avis sur l'utilisateur qui lui a emprunté l'objet.

## Technologies utilisées

Afin de réaliser cette SAÉ, nous avons utilisé Flutter.
La base de données locale est réalisée avec **sqflite** :
    - Les objets de l'utilisateur sont stockés localement.
La base de données distante est réalisée avec **Supabase**.
Afin de naviguer au sein de l'application, nous avons utilisé **GoRouter**.