* Il n'y a actuellement **pas d'intégration SSO**, bien qu'elle puisse être intégrée à un moment donné dans l'application, maintenant qu'elle est supportée par Meteor/Wekan. En attendant, les utilisateurs peuvent créer des comptes (en fait, ils peuvent créer un nombre infini de comptes) manuellement, et doivent se connecter manuellement spécifiquement dans Wekan.
* Cette application **ne fonctionne que sur une architecture x86, 64bits** ! En particulier, elle ne fonctionnera pas sur les machines 32 bits ou ARM. Voir la discussion [ici] (https://github.com/YunoHost-Apps/wekan_ynh/issues/1#issuecomment-401612500).
* Les utilisateurs de YunoHost ayant plus d'une adresse e-mail ne peuvent pas se connecter à wekan en utilisant ldap. Par exemple, le premier utilisateur de YunoHost a plusieurs adresses e-mail : root@domain ; admin@domain ; webmaster@domain ; postmaster@domain, etc.... Solution : supprimez tous les alias de messagerie de l'utilisateur que vous voulez connecter, connectez-vous une fois sur wekan, recréez les alias de l'utilisateur YunoHost.

## Configuration :
L'authentification LDAP étant activée par défaut, les admins de Wekan correspondent à la permission `Wekan Admin`. L'utilisateur que vous choisissez lors de l'installation est membre de ce groupe.
Pour ajouter un compte admin, vous pouvez :

- [avec le webadmin] allez dans Utilisateurs > Groupes et permissions > Ajouter l'utilisateur à la permission `Wekan Admin`.
- [ou avec la ligne de commande] `yunohost user permission update wekan.admin -a the_user_to_add`.

Tous les autres utilisateurs de YunhoHost peuvent accéder avec l'authentification LDAP.

Si vous avez désactivé l'authentification LDAP, le premier utilisateur enregistré sera l'administrateur, et les suivants seront des utilisateurs normaux. Si vous voulez d'autres administrateurs, vous pouvez changer leur permission à admin dans le panneau d'administration de Wekan.
