# Wekan pour YunoHost

[![Niveau d'intégration](https://dash.yunohost.org/integration/wekan.svg)](https://dash.yunohost.org/appci/app/wekan) ![](https://ci-apps.yunohost.org/ci/badges/wekan.status.svg) ![](https://ci-apps.yunohost.org/ci/badges/wekan.maintain.svg)  
[![Installer Wekan avec YunoHost](https://install-app.yunohost.org/install-with-yunohost.svg)](https://install-app.yunohost.org/?app=wekan)

*[Read this readme in english.](./README.md)*
*[Lire ce readme en français.](./README_fr.md)*

> *Ce package vous permet d'installer Wekan rapidement et simplement sur un serveur YunoHost.
Si vous n'avez pas YunoHost, regardez [ici](https://yunohost.org/#/install) pour savoir comment l'installer et en profiter.*

## Vue d'ensemble

Un kanban similaire à Trello

**Version incluse :** 5.93~ynh1



## Captures d'écran

![](./doc/screenshots/screenshot.jpg)

## Avertissements / informations importantes

* There is currently **no SSO integration** though it might be integrated at some point in the app, now that it's supported in Meteor/Wekan. In the meantime, users can create accounts (in fact, they can create infinite number of accounts) manually, and need to login manually specifically in Wekan.
* This app **only works on x86, 64bits architecture**! In particular, it won't work on 32 bit machines or ARM. See the discussion [here](https://github.com/YunoHost-Apps/wekan_ynh/issues/1#issuecomment-401612500).
* YunoHost users with more than one email address can't login to wekan using ldap. For example first YunoHost user has severals email addresses: root@domain; admin@domain; webmaster@domain; postmaster@domain, etc... Workaround: remove all mail aliases of the user you want to connect, connect one time on wekan, recreate the aliases of the YunoHost user.

## Configuration:
As LDAP authentification is enabled by default, Wekan admins correspond to the permission `Wekan Admin`. The user you choose during installation is member of this group.
To add an admin account, you can:

- [with the webadmin] go to Users > Groups and permissions > Add the user to the permission `Wekan Admin`
- [or with the command line] `yunohost user permission update wekan.admin -a the_user_to_add`

All others YunhoHost user can access with LDAP authentication.

If you have disable ldap authentication, first registered user will be admin, and next ones normal users. If you want other admins too, you can change their permission to admin at Wekan Admin Panel.

**Private/Public mode:** In private mode, only authorized YunoHost members can access to the Wekan. 

## Documentations et ressources

* Site officiel de l'app : https://wekan.github.io
* Dépôt de code officiel de l'app : https://github.com/wekan/wekan
* Documentation YunoHost pour cette app : https://yunohost.org/app_wekan
* Signaler un bug : https://github.com/YunoHost-Apps/wekan_ynh/issues

## Informations pour les développeurs

Merci de faire vos pull request sur la [branche testing](https://github.com/YunoHost-Apps/wekan_ynh/tree/testing).

Pour essayer la branche testing, procédez comme suit.
```
sudo yunohost app install https://github.com/YunoHost-Apps/wekan_ynh/tree/testing --debug
ou
sudo yunohost app upgrade wekan -u https://github.com/YunoHost-Apps/wekan_ynh/tree/testing --debug
```

**Plus d'infos sur le packaging d'applications :** https://yunohost.org/packaging_apps