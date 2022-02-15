Faille XSS
Injecter du code dans le code source à l’affichage.
Chercher un champ qui affiche le résultats du texte
Changement en local uniquement

Sur la page ‘feedback’ de notre site, on à cette possibilité avec les champ Name et Message qui sont réaffirmer sur le site par la suite.

Name nous limite en nombre de caractères, on utilisera donc Message.
Tester </br>
Ne modifie pas le contenue de message.

Tester une injection de script : <script>alert(‘Faille XSS’)</script>
Nous donne le flag : 
0FBB54BBF7D099713CA4BE297E1BC7DA0173D8B3C21C1811B916A3A86652724E



Pour éviter cette faille, il faut vérifier le contenu de chaque input. 
On peut utiliser des regex pour interdire certains characters en amont, et surtout sécuriser le contenu des variables affiché qui proviennent d’utilisateur. On peut pour cela on peut utiliser htmlspecialchar($SensibleOutput)
Ici, la sortie ‘comment’ est bien sécurisé car maigres le flag, l’alert ne c’est pas déclenché, pareil pour <?php phpinfo();?>, qui sont nettoyer avant affichage. 
