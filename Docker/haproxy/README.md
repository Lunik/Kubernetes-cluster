# Docker SFTP Image

## How to use

```
docker run \
  -d \
  --restart=always \
  --add-host "kube-node1:172.17.0.142" \
  --add-host "kube-node2:172.17.0.178" \
  -p 80:80 \
  -p 2222:2222 \
  -p 5000:5000 \
  kube-master:5000/haproxy
```
