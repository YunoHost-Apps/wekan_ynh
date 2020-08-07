# Wekan for YunoHost

[![Integration level](https://dash.yunohost.org/integration/wekan.svg)](https://dash.yunohost.org/appci/app/wekan) ![](https://ci-apps.yunohost.org/ci/badges/wekan.status.svg) ![](https://ci-apps.yunohost.org/ci/badges/wekan.maintain.svg)  
[![Install Wekan with YunoHost](https://install-app.yunohost.org/install-with-yunohost.png)](https://install-app.yunohost.org/?app=wekan)

> *This package allows you to install Wekan quickly and simply on a YunoHost server.  
If you don't have YunoHost, please consult [the guide](https://yunohost.org/#/install) to learn how to install it.*

## Overview
Wekan is an open-source kanban board (task manager and organizer)

**Shipped version:** 4.09

## Screenshots

![](screenshot.jpg)

## Status

- This app **only works on x86, 64bits architecture** ! In particular, it won't work on 32 bit machines or ARM. See the discussion [here](https://github.com/YunoHost-Apps/wekan_ynh/issues/1#issuecomment-401612500).

- There is currently **no SSO integration** though it might be integrated at some point in the app, now that it's supported in Meteor/Wekan. In the meantime, users can create accounts (in fact, they can create infinite number of accounts) manually, and need to login manually specifically in Wekan.

## Infos

**Package by:** ljf & Aleks
**Categories:** Productivity, Task

## Configuration

As LDAP authentification is enabled by default, Wekan admins correspond to the permission `Wekan Admin`. The user you choose during installation is member of this group.
To add an admin account, you can:

- [with the webadmin] go to Users > Groups and permissions > Add the user to the permission `Wekan Admin`
- [or with the command line] `yunohost user permission update wekan.admin -a the_user_to_add`

All others YunhoHost user can access with LDAP authentication.

If you have disable ldap authentication, first registered user will be admin, and next ones normal users. If you want other admins too, you can change their permission to admin at Wekan Admin Panel.

**Private/Public mode:** In private mode, only authorized YunoHost members can access to the Wekan. 

## Documentation

 * Official documentation: https://github.com/wekan/wekan/wiki

## YunoHost specific features

#### Multi-user support

LDAP is supported but HTTP auth is still not supported

#### Supported architectures

* x86-64 - [![Build Status](https://ci-apps.yunohost.org/ci/logs/wekan%20%28Apps%29.svg)](https://ci-apps.yunohost.org/ci/apps/wekan/)
* ARMv8-A - [![Build Status](https://ci-apps-arm.yunohost.org/ci/logs/wekan%20%28Apps%29.svg)](https://ci-apps-arm.yunohost.org/ci/apps/wekan/)

## Links

 * Report a bug: https://github.com/YunoHost-Apps/wekan_ynh/issues
 * App website: https://wekan.github.io/
 * Upstream app repository: https://github.com/wekan/wekan
 * YunoHost website: https://yunohost.org/

---

Developer info
----------------

Please send your pull request to the [testing branch](https://github.com/YunoHost-Apps/wekan_ynh/tree/testing).

To try the testing branch, please proceed like that.
```
sudo yunohost app install https://github.com/YunoHost-Apps/wekan_ynh/tree/testing --debug
or
sudo yunohost app upgrade wekan -u https://github.com/YunoHost-Apps/wekan_ynh/tree/testing --debug
```
