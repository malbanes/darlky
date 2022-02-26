Faille crfl

Se rendre sur la page 'mot de passe oublié'
ouvrir l'inspecteur
dans la partie formulaire, rajouter derrière l'email 'webmaster..',
%0ACc: Votre_Email
ce saut de ligne permet d'ajouter des éléments au header ici avoir acces au lien de réinitialisation de mot de passe d'un tiers.

flag : 1D4855F7337C0C14B6F44946872C4EB33853F40B2D54393FBE94F49F1E19BBB0


Pour s'en prémunir, déjà on ne met pas une adresse en dur même en 'hidden' coté client car l'email peut être volé et spammer. Il vaut mieux stocker cette information en back si elle ne doit pas être changé. 
Egalement, il est possible de sécuriser le champ email avec un regex sur caratctère interdit ou des fonctions php tel que str_replace(array("char spé"),'', insecure_input)

aussi, sur la page 'survey' il est possible de voter pour Thor et votant pour Laurie de la même manière, dans la console commande, modifier l'id du sujet par celui souhaiter.
