De la même manière que injection_user,
nous utilisons injection_user/Ressources/shemaBDD.txt pour 'voler' le token de la table db_default

1 AND 1=2 UNION select username, password FROM Member_Brute_Force.db_default


On voit que root et admin ont le même mot de passe
3bf1114a986ba87ed28fc1b5884fc2f8
qui une fois décrypté avec md5 est : shadow

On se rend ensuite sur la page signin
avec root/shadow et admin/shadow on obtien le même flag ci dessous:

B3A6E43DDF8B4BBB4125E5E7D23040433827759D4DE1C04EA63907479A80A6B2

Pour corriger cette faille il faut protéger ses requetes SQL avec sql.prepare avant de l'executer.
Et aussi, penser à cacher les erreurs par des erreurs plus générales sur un site en production (acceptable en dev local ou container sécurisé 'environnement de développement').
