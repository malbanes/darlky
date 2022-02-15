Faille Open Redirect

On trouve le lien en bas de page avec les partages par FB, twitter etc.. 
qui nous permet de modifier la destination de la redirection.
http://192.168.43.114/index.php?page=redirect&site=http://www.malicious.com/login
nous donne le flag : B9E775A0291FED784A2D9680FCFAD7EDD6B8CDF87648DA647AAF4BBA288BCAB3

Ici, faille utiliser pour du phishing, la cible qui utilisera ce lien sera rediriger sur notre site malicieux de là on pourrait lui demander de se connecter à nouveau et voler ses identifiants.

pour corriger cette faille on peut utiliser une liste blanche de destinations,
signer les redirection avec un hash afin de controler l'url vers laquelle l'utilisateur est redirigé
