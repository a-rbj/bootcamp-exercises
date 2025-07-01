#!/bin/bash

apt install -y default-jre > /dev/null 2>&1

status=$(java --version 2>/dev/null |awk {'print $2'} |head -n1)
version="${status%%.*}"

if [ "$version" == "" ]
then
	echo "Java ne s'est pas installé"
elif [ $version -lt 11 ]
then
	echo "Il existe une version de Java plus récente"
else
	echo "Java s'est bien installé. Voici sa version : $status"
fi
