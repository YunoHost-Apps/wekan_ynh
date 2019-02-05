# Wekan for Yunohost

[![Integration level](https://dash.yunohost.org/integration/wekan.svg)](https://dash.yunohost.org/appci/app/wekan)  
[![Install Wekan with YunoHost](https://install-app.yunohost.org/install-with-yunohost.png)](https://install-app.yunohost.org/?app=wekan)

> *This package allow you to install wekan quickly and simply on a YunoHost server.  
If you don't have YunoHost, please see [here](https://yunohost.org/#/install) to know how to install and enjoy it.*

## Overview
Wekan is an open-source kanban board (task manager and organizer)

**Shipped version:** 2.09

## Screenshots

![](screenshot.jpg)

## Status

- This app only works on x86, 64bits architecture ! In particular, it won't work on 32 bit machines or ARM. See the discussion [here](https://github.com/YunoHost-Apps/wekan_ynh/issues/1#issuecomment-401612500). On the long term, [support for ARM64 might happen](https://blog.wekan.team/2018/01/wekan-progress-on-x64-and-arm/index.html)...

- There is currently no SSO/LDAP integration though it might be integrated at some point in the app, now that it's supported in Meteor/Wekan. c.f. discussion in [here](https://github.com/YunoHost-Apps/wekan_ynh/issues/4). In the meantime, users can create accounts (in fact, they can create infinite number of accounts) manually, and need to login manually specifically in Wekan.

## Infos

**Package by:** ljf & Aleks
**Categories:** Productivity, Task

**Upgrade this package:**  
`sudo yunohost app upgrade --verbose wekan -u https://github.com/YunoHost-Apps/wekan_ynh`

**Multi-user:** Yes. 

**Private/Public mode:** In private mode, only authorized YunoHost members can access to the wekan. 

**SSO/LDAP:** SSO and LDAP are not configured.

## Configuration

First registered user will be admin, and next ones normal users. If you want other admins too, you can change their permission to admin at Wekan Admin Panel.

## Documentation

 * Official documentation: https://github.com/wekan/wekan/wiki

## YunoHost specific features

#### Supported architectures

* x86-64b - [![Build Status](https://ci-apps.yunohost.org/ci/logs/wekan%20%28Community%29.svg)](https://ci-apps.yunohost.org/ci/apps/wekan/)
* ARMv8-A - [![Build Status](https://ci-apps-arm.yunohost.org/ci/logs/wekan%20%28Community%29.svg)](https://ci-apps-arm.yunohost.org/ci/apps/wekan/)
* Jessie x86-64b - [![Build Status](https://ci-stretch.nohost.me/ci/logs/wekan%20%28Community%29.svg)](https://ci-stretch.nohost.me/ci/apps/wekan/)

## Limitations

* Any known limitations.

## Links

 * Report a bug: https://github.com/YunoHost-Apps/wekan_ynh/issues
 * App website: https://wekan.github.io/
 * Github App website: https://github.com/wekan/wekan
 * YunoHost website: https://yunohost.org/

---

Developers info
----------------

**Only if you want to use a testing branch for coding, instead of merging directly into master.**
Please do your pull request to the [testing branch](https://github.com/YunoHost-Apps/wekan_ynh/tree/testing).

To try the testing branch, please proceed like that.
```
sudo yunohost app install https://github.com/YunoHost-Apps/wekan_ynh/tree/testing --debug
or
sudo yunohost app upgrade wekan -u https://github.com/YunoHost-Apps/wekan_ynh/tree/testing --debug
```
