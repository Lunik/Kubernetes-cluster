# Docker SFTP Image

## How to use

```
docker run -e USER=foo -e PASS=bar -p 2222:22 kube-master:5000/sftp

sftp -P 2222 foo@localhost
```
