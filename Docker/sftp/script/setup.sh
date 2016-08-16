#!/bin/sh

sed -e 's/\(^uri ldap:\/\/\)\${LDAP_IP}:\${LDAP_PORT}$/\1'"$SVC_LDAP_SERVICE_HOST:$SVC_LDAP_SERVICE_PORT"'/' /etc/nslcd.conf -i

/usr/sbin/nslcd
/usr/sbin/sshd -D