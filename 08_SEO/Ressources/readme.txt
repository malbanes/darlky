Faille SEO (robots.txt)
Tous bon site utilise des méthodes de référencement pour être visible dans les moteurs de recherches. Ces dernier peuvent ouvrir des failles de sécurités.  

Le fichier robots.txt se trouve au niveau de la racine de votre site internet

Go to http://192.168.1.21/robot.txt
Voir le contenu de /whatever
	on y trouve htpasswd à télécharger avec root:8621ffdbc5698829397d97767ac13db3
Le mdp décrypté en md5: dragon
Le mdp est différent du root de signup, je soupsonne donc se couple id/mdp de nous donner accès au panel admin. 
En effet, entrer root:dragon dans http://ip/admin nous donne le flag : 
d19b4823e0d5600ceed56d5e896ef328d7a2b9e7ac7e80f4fcdb9b10bcb3e7ff

Pour sécuriser cette faille, il est possible de protéger les dossiers sensible via des .htaccess. Les page/dossier protégé par mot de passe ne sont pas référencé il est donc possible de les retirer de robots.txt. On peut aussi utiliser dans le .htacces  ‘Header set x-robots-tag: noindex’ qui permettra au dossier de ne pas être affiché.
