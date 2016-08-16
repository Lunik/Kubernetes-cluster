#!/bin/sh

if [[ "$1" = "-h" ]] || [[ -z "$2" ]]
then
  echo "Usage: encrypt_decrypt.sh [encrypt|decrypt] <passphrase>"
  exit
fi

pass="$2"

if [[ "$1" = "encrypt" ]]
then
  rm ./Docker/sftp/encrypted-key/*
  for file in $(find ./Docker/sftp/key -type f)
  do
    futurFile=$(echo "$file" | sed -e 's/\/key\//\/encrypted-key\//')
    gpg -a --batch -q --passphrase "$pass" --cipher-algo AES256 -o "$futurFile".gpg -c "$file"
  done
else
  mkdir ./Docker/sftp/key
  for file in $(find ./Docker/sftp/encrypted-key -type f)
  do
    futurFile=$(echo "$file" | sed -e 's/\/encrypted-key\//\/key\//' | sed -e 's/\.gpg//')
    gpg -a --batch -q --passphrase "$pass" -o "$futurFile" --decrypt "$file"
  done
fi
