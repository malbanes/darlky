#03_ORED

##Research explanation
- At the bottom of each page of the website, there is a redirection link embedded with the FB, Twitter, and Instagram buttons.
- We just have to modify the destination URL with another malicious one
Example: From: http://192.168.43.114/index.php?page=redirect&amp;site=facebook to: http://192.168.43.114/index.php?page=redirect&site=http://www.malicious.com/login
- The flag is there: B9E775A0291FED784A2D9680FCFAD7EDD6B8CDF87648DA647AAF4BBA288BCAB3

##Breach Details 
- In this case, the breach is used for phishing.
- The targeted user will click on a link that will redirect him to our malicious website.
- Then, we can ask him to connect himself to this malicious website to steal his credentials.

Recommendation: 
- To avoid this kind of breach, we can use a white-list of destination URLs - This should be based on an allow-list approach, rather than a block list.
- We can also sign the redirections using a hash to control and confirm to which URL the user is currently redirected.
- Another best practice is to avoid using redirects and forwards simply.
- Additional info: https://cheatsheetseries.owasp.org/cheatsheets/Unvalidated_Redirects_and_Forwards_Cheat_Sheet.html

##How to:
- Go at the bottom of the page,
- Find the URL structure of the social network redirection URLs: Example -  http://192.168.43.114/index.php?page=redirect&amp;site=facebook
- Replace the 'redirect' part of the URL with the one you want: http://192.168.43.114/index.php?page=redirect&site=http://www.malicious.com/login
- The flag is there.