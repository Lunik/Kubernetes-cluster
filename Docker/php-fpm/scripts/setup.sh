#!/bin/sh

if [ ${#UID} -gt 0 ]
then
	sed -e 's/www-data/'$UID'/g' -i /usr/local/etc/php-fpm.d/www.conf
fi

php-fpm