```
ldapsearch -h $SVC_LDAP_SERVICE_HOST:$SVC_LDAP_SERVICE_PORT \
	-D "cn=Manager,dc=exemeple,dc=fr" -w root \
	-b "ou=People,dc=exemeple,dc=fr" "uidNumber" \
	| grep uidNumber | sed -e "s/uidNumber: //g"
```