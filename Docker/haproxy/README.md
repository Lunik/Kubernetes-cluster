# Docker SFTP Image

## How to use

```
docker run \
  -d \
  --restart=always \
  --add-host "kube-node1:x.x.x.x" \
  --add-host "kube-node2:x.x.x.x" \
  -p 5000:5000 \
  kube-master:5000/haproxy
```
