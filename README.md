# Wekan for Yunohost

Attempt to package Wekan for Yunohost....

## Status

For the moment it kind of works, but this is still experimental and has not been much tested. DO NOT DEPLOY IN PRODUCTION.

The main drawback at the moment is that it's [not integrated with the LDAP](https://github.com/wekan/wekan/issues/119). So users have to create accounts (and can create infinite number of accounts) manually, and need to login manually specifically in Wekan.

## Infos
**Package by:** ljf & Aleks

**Categories:** Productivity, Task

**Upgrade this package:**  
`sudo yunohost app upgrade --verbose LimeSurvey -u https://github.com/YunoHost-Apps/wekan_ynh`

**Multi-user:** Yes. 

**Private/Public mode:** In private mode, only authorized YunoHost members can access to the wekan. 

**SSO/LDAP:** SSO and LDAP are not configured.

## To-do

- Test / make it work on ARM
- LDAP is not yet integrated in Wekan, unfortunately... but some people did tweak things as discussed [here](https://github.com/wekan/wekan/issues/119#issuecomment-224319252)
