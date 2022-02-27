#5-Root_Password Breach

##Research explanation
- A common OWASP breach is to get access to the Webserver Metafiles to find suitable information, files, or paths as mentioned on owasp website:  https://owasp.org/www-project-web-security-testing-guide/latest/4-Web_Application_Security_Testing/01-Information_Gathering/03-Review_Webserver_Metafiles_for_Information_Leakage
- Let's try to find the robots.txt file and see what we can find
- I loaded the http://192.168.56.101/robots.txt page. 2 paths seems available, I tried the first one to start: http://192.168.56.101/whatever/
- A downloadable file is there: 'htpasswd'. It seems it contains the root username and maybe a password.
- I tried the [root, 8621ffdbc5698829397d97767ac13db3] couple on the http://192.168.56.101/index.php?page=signin page, with no success
- Maybe the password  is hashed. I tried to decode the hash '8621ffdbc5698829397d97767ac13db3' using https://www.dcode.fr/fonction-hash and its encription automatic detection. A word is found 'dragon'
- I tried this time the [root, dragon] couple on the http://192.168.56.101/index.php?page=signin page, with no success
- After few researches on the web, I found few methods to start a web crawler on the website. the fist method 'wget -r -l0 192.168.56.101' was not really interesting for the moment. 
- Usualy an admin panel is available on the website, we check if http://ip/admin exist. 
- I chose to focus on the admin page and it worked.
- I tried the [root, 8621ffdbc5698829397d97767ac13db3] couple and [root, dragon] couple and the second one worked!

##Breach Details 
- Web Spiders, Robots, or Crawlers retrieve a web page and then recursively traverse hyperlinks to retrieve further web content.
- Even if the Disallow directive specifies which resources are prohibited by spiders/robots/crawlers. We can still have an access to the file.
- So it should not be the place to host sensitive data.

Recommendation: 
- Host sensitive info or credentials always on in a secure place, not inside an unlisted file.
- The usage of .htaccess and/or .htpasswd file will reduce the risk of unwanted access. These file accesses should also be resticted (exemple: https://docs.ovh.com/gb/en/hosting/how_to_password_protect_a_directory_on_your_website/)

##How to:
- Load http://192.168.56.101/robots.txt
- Download the file available here http://192.168.56.101/whatever/
- Decode the hash - 8621ffdbc5698829397d97767ac13db3 - using https://www.dcode.fr/fonction-hash
- Open http://192.168.56.101/admin/ webpage and put [root, dragon] auth couple.
- Flag is there


https://www.infosecmatter.com/nmap-nse-library/?nse=http-enum