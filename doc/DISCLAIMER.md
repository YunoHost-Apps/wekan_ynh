* Any known limitations, constrains or stuff not working, such as (but not limited to):
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
