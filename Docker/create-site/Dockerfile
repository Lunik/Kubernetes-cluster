FROM alpine:latest

MAINTAINER Guillaume Martinez <guillaume.martinez@cc.exemple.fr>

RUN apk --update add openldap-clients

ADD config/user.ldif /tmp/user.ldif
ADD scripts/setup.sh /setup

CMD ["/setup"]