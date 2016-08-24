FROM php:7.0.8-fpm-alpine
MAINTAINER Guillaume Martinez <guillaume.lunik@gmail.com>

ADD conf/php5-fpm.conf /usr/local/etc/php-fpm.conf
ADD scripts/setup.sh /setup

CMD ["/setup"]