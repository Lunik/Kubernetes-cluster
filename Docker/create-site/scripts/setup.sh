#!/bin/sh
UID_MIN=32000
UID_MAX=34999

if [ ${#SVC_LDAP_SERVICE_PORT} -eq 0 ] || [ ${#SVC_LDAP_SERVICE_HOST} -eq 0 ]
then
	echo "SVC_LDAP_SERVICE_HOST or SVC_LDAP_SERVICE_PORT is not set."
	exit 1
fi

if [ ${#LDAP_USER} -eq 0 ] || [ ${#LDAP_PASS} -eq 0 ]
then
	echo "LDAP_USER or LDAP_PASS is not set."
	exit 1
fi

if [ ${#USER} -eq 0 ] && [ ${#PASS} -eq 0 ]
then
	echo "PASS or USER is not set."
	exit 1
fi


echo "uri ldap://$SVC_LDAP_SERVICE_HOST:$SVC_LDAP_SERVICE_PORT" >> /etc/openldap/ldap.conf
echo "base dc=exemple,dc=fr" >> /etc/openldap/ldap.conf

echo "User config: uid=$USER,ou=People,dc=exemple,dc=fr"

if [ $1 = "create" ]
then 
	sed -e 's/{{USER}}/'$USER'/g' -i /tmp/user.ldif

	takenUids=$(ldapsearch -h $SVC_LDAP_SERVICE_HOST:$SVC_LDAP_SERVICE_PORT -D "cn=$LDAP_USER,dc=exemple,dc=fr" -w $LDAP_PASS -b "ou=People,dc=exemple,dc=fr" "uidNumber" | grep uidNumber: | sed -e "s/uidNumber: //g")
	userUid=$UID_MIN
	for uid in $takenUids
	do
		if [ $userUid = $uid ]
		then
			userUid=$(( userUid + 1))
			if [ $userUid = $UID_MAX]
			then
				echo "No more UID."
				exit 1
			fi
		else
			break
		fi
	done

	echo "Found free UID: $userUid."

	sed -e 's/{{UID}}/'$userUid'/g' -i /tmp/user.ldif

	ldapadd -D "cn=$LDAP_USER,dc=exemple,dc=fr" -w $LDAP_PASS -f /tmp/user.ldif 
	code=$?
	if [ $code -ne 0 ]
	then
		echo "Error on LDAP ADD. Code: $code"
		exit 1
	fi

	ldappasswd  -D "cn=$LDAP_USER,dc=exemple,dc=fr" -w $LDAP_PASS -s $PASS "uid=$USER,ou=People,dc=exemple,dc=fr"
	code=$?
	if [ $code -ne 0 ]
	then
		echo "Error on LDAP PASSWD. Code: $code"
		exit 1
	fi

	mkdir /sites/$USER
	code=$?
	if [ $code -ne 0 ]
	then
		echo "Error on MKDIR. Code: $code"
		exit 1
	fi	
	chown -R $userUid:$userUid /sites/$USER
	code=$?
	if [ $code -ne 0 ]
	then
		echo "Error on CHOWN. Code: $code"
		exit 1
	fi
			
fi

if [ $1 = "delete" ]
then
	ldapdelete -D "cn=$LDAP_USER,dc=exemple,dc=fr" -w $LDAP_PASS "uid=$USER,ou=People,dc=exemple,dc=fr"
	code=$?
	if [ $code -ne 0 ]
	then
		echo "Error on LDAP DELETE. Code: $code"
		exit 1
	fi

	tar zcf /sites/$USER.tar.gz /sites/$USER
	rm -rf /sites/$USER
	code=$?
	if [ $code -ne 0 ]
	then
		echo "Error on RM -rf. Code: $code"
		exit 1
	fi
fi

exit 0
