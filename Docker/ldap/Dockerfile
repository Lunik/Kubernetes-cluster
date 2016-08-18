FROM alpine:latest
MAINTAINER Guillaume Martinez <guillaume.martinez@cc.exemple.fr>

RUN apk --update --no-cache add openldap

ADD config/slapd.conf /etc/openldap/slapd.conf

RUN mkdir /var/lib/openldap-data

EXPOSE 389

CMD ["slapd", "-d", "2"]
