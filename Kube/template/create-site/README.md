# How to create site

```
$ ./create_site.sh create <site> <password>
$ kubectl create -f job.yml && kubectl create -f site.yml

# wait until the job as finished
$ kubectl get jobs

$ kubectl delete -f job.yml
```

# How to delete site

```
$ ./create_site.sh delete <site>
$ kubectl create -f job.yml && kubectl delete -f site.yml

# wait until the job as finished
$ kubectl get jobs

$ kubectl delete -f job.yml
```
