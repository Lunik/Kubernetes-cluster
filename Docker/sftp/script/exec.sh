#!/bin/sh

if [[ $SSH_ORIGINAL_COMMAND =~ rsync* ]]
then
        /usr/bin/rsync --server -vlogDtpre.iLsf . ~
        exit 0
fi

if [[ $SSH_ORIGINAL_COMMAND = "internal-sftp" ]]
then
        /usr/libexec/openssh/sftp-server
        exit 0
fi


if [[ $SSH_ORIGINAL_COMMAND =~ scp* ]]
then
        scp -rt ~
        exit 0
fi

echo "Unauthorised command."
exit 1