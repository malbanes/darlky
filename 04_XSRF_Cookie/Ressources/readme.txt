sur index.php?page=(n'importe quel page)

j'utilise maintenant https://md5decrypt.net/#answer pour gérer le cryptage, décryptage
dans la console command, stockage on trouve un Cookie qui n'est pas expiré
avec pour nom 'I_am_admin'
sa valeur, encore une fois, décrypté en md5 vaut 'false' 
Que se passe t'il si on modifie la valeur du cookie par 'true' crypté avec md5 dont la valeur est :
b326b5062b2f0e69046810717534cb09   ?
On obtien dirrectement un flag par un prompt.


Cette faille s'apparente à un vol de session qui ici, ne nous permet pas d'action supplémentaire. 
Pour l'éviter, il suffit de générer un cookie unique aléatoire à l'authentification qui sera aussi sauvegarder en base de donnée et de faire la comparaison en back.
