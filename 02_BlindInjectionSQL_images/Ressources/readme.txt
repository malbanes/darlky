Une autre page avec des requetes sql est SearchImage. 
url au format /index.php?page=searchimg&id=1&Submit=Submit

L'input est vulnérable car comme dans Member : 1 or 1=1 retourne bien toutes les images.
Cette fois-ci, les messages d'erreurs sont caché car 1 AND 1=2 UNION SELECT Commentaire, countersign FROM users WHERE user_id=5 ne retourne rien. 

Imaginons que nous n'avont pas 'mapper' la bdd avec la faille sql précédente, 
il reste un moyen de trouver le nom de la base, table et colonne. Le blind-sql.
On vérifie que la faille est exploitable en cherchant une différence entre un résultats valide et invalide. 
1 and 1=1 retourne bien un élément (true état) et 1 and 1=2 ne retourne rien (false état)
Avec cela, on peut poser une série de question true/false pour déterminer quand une requete est executé. 
comme :
1 AND 1=1 UNION SELECT COLUMN_NAME, TABLE_NAME FROM information_schema.COLUMNS

On trouve à nouveau une table 
list_images avec les éléments : id/url/title/comment. 
Seul comment n'est pas affiché par défaut. On vas donc demander à le voir.

1 AND 1=1 UNION SELECT title, comment FROM list_images

Si on veut savoir dans quelle base on se trouve faire:
1 AND 1=2 UNION SELECT table_name, table_schema FROM information_schema.tables
->Member_images

On trouve un indice, un peu plus qu'un indice même, ici on nous donne la méthode de hashage, la clé et la méthode :
First name: If you read this just use this md5 decode lowercase then sha256 to win this flag ! : 1928e8083cf461a51303633093573c46
 ce qui nous donne décrypté: albatroz
 puis crypté en sha256 le token : 
f2a29020ef3132e01dd61df97fd33ec8d7fcd1388cc9601e7db691d17d4d6188

Pour corriger cette faille, il est possible d'encapsuler l'input en paramètre avec php en utilisant PHP Data Objects (PDO)
Qui permet de limiter la porté de la requete. (empèche l'interpretation de UNION, AND etc..)
Il est important de cacher une ou plusieurs bases sensibles tel que information.schema
C'est possible en utilisant phpmyadmin dans config.inc.php
rajouter,
$cfg['Servers'][$i]['hide_db'] = 'information_schema|performance_schema|mysql';