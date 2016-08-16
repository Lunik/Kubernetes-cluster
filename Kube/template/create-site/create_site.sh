#!/bin/sh
function Usage(){
	echo "Usage: ./create_site.sh [create|delete] <site> <pass>"
}

if [ "$1" = "-h" ]
then
	Usage
	exit 0
fi

if [ "$1" = "create" ] || [ "$1" = "delete" ]
then
	mode="$1"
else
	Usage
	exit 1
fi

user="$2"
pass="$3"

if [ ${#user} -eq 0 ] || [ ${#pass} -eq 0 ]
then
	echo 'Missing User or Pass.'
	Usage
	exit 1
fi

site="$user"

echo "==> Templating du job."

echo "---" > job.yml
cat create_site_job.yml >> job.yml
sed -e 's/{{MODE}}/'$mode'/' job.yml -i
sed -e 's/{{USER}}/'$user'/' job.yml -i
sed -e 's/{{PASS}}/'$pass'/' job.yml -i
sed -e 's/{{NAME}}/'$site'/g' job.yml -i

echo "==> Creation du job."
kubectl create -f job.yml

echo "==> Attente de la fin du job."
status="0"
while [ $status != "1" ]
do
	status=$(kubectl get jobs --selector=job-name=$mode-site-$site | tail -1 | awk '{print $3}')
	sleep 1
done

echo "==> Attente de la fin des pods."
status="0"
while [ $status != "Completed" ]
do
	status=$(kubectl get pods -a --selector=job-name=$mode-site-$site | tail -1 | awk '{print $3}')
	sleep 1
done

uid=0
if [ $mode = "create" ]
then
	echo "==> Récupération de l'UID."
	uid=$(kubectl logs $(kubectl get pods -a --selector=job-name=$mode-site-$site | tail -1 | awk '{print $1}') | grep UID: | sed -e 's/^.*UID: \([0-9]*\)./\1/')
	echo "UID: $uid"
fi

echo "==> Supression du job."
kubectl delete -f job.yml

echo "==> Templating du site."
echo "---" > site.yml
cat ../site/deployment.yml >> site.yml
echo "---" >> site.yml
cat ../site/ingress.yml >> site.yml
echo "---" >> site.yml
cat ../site/service.yml >> site.yml

sed -e 's/{{NAME}}/'$site'/g' site.yml -i
sed -e 's/{{UID}}/'$uid'/g' site.yml -i

if [ $mode = "create" ]
then
	echo "==> Creation du site."
	kubectl create -f site.yml
fi

if [ $mode = "delete" ]
then
	echo "==> Supression du site."
	kubectl delete -f site.yml
fi

echo "====================="
echo "You have $mode a site"
echo "Info:"
echo "  Name:	$site"
if [ $mode = "create" ]
then
	echo "  User:	$user"
	echo "  Pass:	$pass"
	echo "  Uid:	$uid"
	echo "  Url:	$site.exemple.fr"
fi
exit 0
