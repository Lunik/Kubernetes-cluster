FROM alpine:latest

MAINTAINER Guillaume Martinez <guillaume.lunik@gmail.com>

RUN apk --update add openldap-clients

ADD config/user.ldif /tmp/user.ldif
ADD scripts/setup.sh /setup
ADD scripts/wait.sh /wait

CMD ["/setup"]