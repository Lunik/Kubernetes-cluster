FROM alpine:latest
MAINTAINER Guillaume Martinez <guillaume.lunik@gmail.com>

RUN apk --update --no-cache add \
	openldap \
	openldap-clients

ADD config/slapd.conf /etc/openldap/slapd.conf

RUN mkdir /var/lib/openldap-data

EXPOSE 389

CMD ["slapd", "-d", "2"]
