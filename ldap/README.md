# WebDAV and LDAP with phpmyadmin
This solution creates 3 docker containers to run LDAP with WebDAV using phpmyadmin as a web UI.

## Usage
To run the containers simply use the docker command:

```bash
docker-compose up
```
The project creates an LDAP repo that is mapped to your home directory.
The ldif file bootstrap.ldif creates two users, John Doe and Jane Doe. To access the LDAP database simply login to localhost:3000 and input the username and password(eg. u:jane p:jane). To manage the groups and users through phpmyadmin login to localhost:8080 and use the following:
    username: cn=admin,dc=example,dc=org
    password: admin

*Note* If the containers are stopped, you will have to run 'docker-compose down' before deploying again, otherwise mounting bootstrap.ldif will fail. This is a workaround for the following issue:
https://github.com/osixia/docker-openldap/issues/179

## Credits
The project was forked and altered from the following github page:

https://github.com/Edirom/webdav-ldap-httpd

