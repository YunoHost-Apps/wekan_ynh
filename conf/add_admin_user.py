import ldapsync

def ldap_sync():
    print("Fetching user __ADMIN__ from LDAP")
    ldap = LdapConnection()
    ldap_user = ldap.get_users()['__ADMIN__']
    ldap_user['is_superuser'] = True
    
    print("Fetching users from Wekan")
    wekan_username_list = []
    for user in mongodb_database["users"].find():
        if not user['loginDisabled']:
            wekan_username_list.append(user['username'])

    print("Sorting users")
    in_wekan = '__ADMIN__' in wekan_username_list
    
    print("Processing users")
    if in_wekan:
        print(f"User in Wekan, updating {ldap_user}")
        update_wekan_user(ldap_user)
    else:
        print(f"User not in Wekan, adding {ldap_user}")
        create_wekan_user(ldap_user)

    print("Done")

if __name__ == "__main__":
    ldap_sync()
