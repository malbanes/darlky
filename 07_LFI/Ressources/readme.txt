La faille Local File Inclusion

Exploite une variable non protéger utilisé par un include(),
c'est le cas ici pour les pages car l'url est de format : index.php?page=signin Le '?' signale que la suite est un argument get en back on peut imaginer quelque chose comme : include $page 
on peut essayer d'afficher d'autres fichier que ceux prévus en mettant le chemin d'un fichier comme /etc/passwd pour avoir les droits root sur la machine. 
Sur les machines de l'école on utilise apache2, on peut imaginer que l'emplacement de index.php : /var/www/html/mynewsite/index.php , pour remonter à /etc/ ils faut essayer : ../../../../etc/passwd
un prompt nous indique que nous sommes en bonne voie : Almost
On ne vas pas chercher plus loin. /etc/ se trouve à la racine donc on remonte suffisament pour être sure de ne plus pouvoir remonter : 
../../../../../../../../../../etc/passwd

flag: b12c4b2cb8094750ae121a676269aa9e2872d07c06e429d25a63196ec1c8c1d0 


Pour éviter cette faille il faut sécuriser $page. Il est préférable d'utiliser des 'id' de page, vérifier qu'ils soient numériques et les comparer en bdd pour limiter les entrée. sinon, système de routing, ou vérifier le contenu de $page
