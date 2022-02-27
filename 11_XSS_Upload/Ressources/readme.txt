En bas de la page home, on trouve un lien qui nous permet d'upload une image.
On vas essayer d'injecter du code par ce biais. 
Pour ce faire, on test si l'upload vérifie bien le type de fichier envoyé en envoyant un script bidon en php.
Ca ne marche pas. 

/tmp/bidon64.php.jpg succesfully uploaded.

Mais on accede pas à url/tmp/bidon64.php.jpg.

Essayont maintenant de forcer le type php vers jpg avec curl (spoof)

When the -F option is used, curl sends the data using the multipart/form-data Content-Type
c'est bien le format utiliser par le formulaire.
On remet les élément demandé par ce dernier: file, maxFileSize et Upload

Pour envoyer un fichier avec curl il faut utiliser '@',
On fournis à la requete un MimeType différent de .php qui sera accepté (.jpg) et on test.
file est un objet qui contient plusieurs 'variable' 
tel que name, type, size. Pour tromper le serveur nous allons directement modifier le Mimetype avec la variable 'type'.
:you can specify the content-type for a part you upload by adding ";type=mime/type". 

ps: replace lien du script .php par l'endroit ou il se trouve. 

chemin possible dans le dossier courant
curl -X POST -F 'uploaded=@bidon.php;type=image/jpg' -F 'MAX_FILE_SIZE=100000' -F 'Upload=Upload' 'http://192.168.1.21/index.php?page=upload' | grep 'flag'

On trouve le flag : 46910d9ce35b385885a9f7e2b336249d622f29b267a1771fbacf52133beddba8

Résoudre la faille: 
isoler les fichiers chargés dans un dossier à part pour minimiser les risque 
de rebond au cas où il s'agit d'un fichier malveillant. 
Renommer les fichiers chargés sera aussi d'une grande utilité car le pirate aura du mal à appeler son fichier s'il ne connait pas son chemin et son nom. 
Une bonne pratique consiste à changer les droits du fichier chargé à l'aide de la fonction chmod().
utiliser en back php getSize(img) si false, fausse image