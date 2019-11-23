#!/bin/sh

# Add our dav location to the httpd config
cat <<EOF > /usr/local/apache2/conf/extra/webdav.conf
LoadModule	dav_module           modules/mod_dav.so
LoadModule  dav_fs_module        modules/mod_dav_fs.so
LoadModule	ldap_module          modules/mod_ldap.so
LoadModule	authnz_ldap_module   modules/mod_authnz_ldap.so
DocumentRoot "/var/webdav"
DavLockDB "/run/lock/apache/DavLock.db"

PassEnv AuthLDAPURL
PassEnv AuthLDAPBindDN
PassEnv AuthLDAPBindPassword
PassEnv RequireLDAPGroup

# rewriting Destination because we're behind an SSL terminating reverse proxy
# see http://www.dscentral.in/2013/04/04/502-bad-gateway-svn-copy-reverse-proxy/  
RequestHeader edit Destination ^https: http: early

<Directory "/var/webdav">
    DAV on
    Options +Indexes
    IndexOptions Charset=UTF-8 FancyIndexing FoldersFirst
    IndexIgnore .??* :2*
    AllowOverride None
    AuthName "Noima WebDAV: Login with username and password" 
    AuthBasicProvider ldap
    AuthType Basic
    AuthLDAPGroupAttribute ${AuthLDAPGroupAttribute} 
    AuthLDAPGroupAttributeIsDN ${AuthLDAPGroupAttributeIsDN}
    AuthLDAPURL ${AuthLDAPURL}
    AuthLDAPBindDN "${AuthLDAPBindDN}" 
    AuthLDAPBindPassword "${AuthLDAPBindPassword}"
    Require ldap-group ${RequireLDAPGroup}
</Directory>
EOF

# Set the user running httpd
# if parameter $RUNAS_USER is set.
# Otherwise defaults to user daemon
if [ -n "$RUNAS_USER" ]; then
    sed -i -e "s@User daemon@User $RUNAS_USER@" ${HTTPD_PREFIX}/conf/httpd.conf
fi

# Run the command given in the Dockerfile at CMD 
exec "$@"
