Se rendre sur la page membre
the single quotation mark is not required if you are injecting into a numeric data field or column name

Trouver le nom de la base de donnée avec un union bidon type : 2 union select * from lol
Ce qui nous donne cette sortie : Table 'Member_Sql_Injection.lol' doesn't exist
Le nom de la bdd est Member_Sql_Injection

On peut également dump tous les membre avec : 1 or 1=1
on remarque que la sortie de la requete necessite 3 valeurs, ID, First name et Surname.
On peut ensuite afficher le noms de toutes les bases et tables existantes grace à 
1 AND 1=2 UNION SELECT table_name, table_schema FROM information_schema.tables
cela nous permet de faire un petit shema des bases et leurs tables.

Ensuite, on affiche le nom des tables et ses colonnes avec, comme décrit plus tot, 3 éléments, 2 plus l'id ou ici la requete : 
1 AND 1=2 UNION SELECT COLUMN_NAME, TABLE_NAME FROM information_schema.COLUMNS

Voilà que notre shema de l'architecture de la BDD est complête. Nous pourvons nous en servir pour récupérer toutes les informations du serveur.
Je l'ai nommé shemaBDD.txt et nous servira à récupérer plusieurs flags.

Ici, on se trouve dans la table "Member_Sql_Injection" c'est donc dans cette Base de donnée que nous allons chercher le flag : 

Dans la talbe users, 2 éléments sortent du lot: countersign et Commentaire. Allons les explorer avec : 

avec 1 AND 1=2 UNION SELECT Commentaire, countersign FROM users WHERE user_id=5 on trouve un indice :
Decrypt this password -> then lower all the char. Sh256 on it and it's good !
et le flag crypté: 5ff9d0165b4f92b14994e5c685cdce28
on utilisera un reverse hash avec la méthode de cryptage la plus utilisé à 42 'md5' pour décoder le password : 
https://md5hashing.net/hash and choose MD5
on trouve le char décrypté: FortyTwo, lower the case et donc 
plainflag = fortytwo
on nous demande ensuite de le crypter avec sha256
on trouve le flag: 10a16d834f9b1e4068b25c4c46fe0284e99e44dceaf08098fc83925ba6310ff5

Pour corriger cette faille il faut protéger ses requetes SQL avec sql.prepare avant de l'executer.
Et aussi, penser à cacher les erreurs par des erreurs plus générales sur un site en production (acceptable en dev local ou container sécurisé 'environnement de développement').