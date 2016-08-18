```
ldapsearch -h $SVC_LDAP_SERVICE_HOST:$SVC_LDAP_SERVICE_PORT \
	-D "cn=Manager,dc=exemple,dc=fr" -w root \
	-b "ou=People,dc=exemple,dc=fr" "uidNumber" \
	| grep uidNumber | sed -e "s/uidNumber: //g"
```