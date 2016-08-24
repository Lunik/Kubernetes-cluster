# ALPINE

#FROM alpine:latest
#MAINTAINER Guillaume Martinez <guillaume.lunik@gmail.com>

#RUN apk --update --no-cache add openssh

#ADD config/sshd_config /etc/ssh/sshd_config
#ADD script/setup.sh /setup
#ADD key /etc/ssh/key

#RUN chmod 600 /etc/ssh/key/* && \
#    chmod 644 /etc/ssh/key/*.pub

#EXPOSE 22

#CMD ["/setup"]


# CENTOS

FROM centos:centos7

MAINTAINER Guillaume Martinez <guillaume.lunik@gmail.com>

RUN yum -y install epel-release && \
	yum -y install \
	openssh-server \
	openssh-clients \
	rsync \
	nss-pam-ldapd && \
	yum clean all

# Config OpenSSH
ADD config/sshd_config /etc/ssh/sshd_config

ADD script/exec.sh /exec

ADD key /etc/ssh/key
RUN chmod 600 /etc/ssh/key/* && \
    chmod 644 /etc/ssh/key/*.pub

# Config Pam LDAP
ADD config/nslcd.conf /etc/nslcd.conf
ADD config/nsswitch.conf /etc/nsswitch.conf
ADD config/pam /etc/pam.d/system-auth
ADD config/pam /etc/pam.d/sshd

EXPOSE 22

ADD script/setup.sh /setup

CMD ["/setup"]