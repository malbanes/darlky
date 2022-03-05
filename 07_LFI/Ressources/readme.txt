#07_LFI

##Research explanation
- After some research, another possible attack is the Local File Inclusion using Directory traversal (is also known as the ../ (dot dot slash) attack) hack - https://owasp.org/www-community/attacks/Path_Traversal
- In our case, we will try to exploit an unprotected variable used by an 'include()' element.
- Indeed, as we can notice, the website is using it: the URLs structure uses the '?' element (ex: index.PHP?page=signin).
- The '?' shows that the following elements are based on a get request sent to the backend, using arguments maybe following this kind of element: 'include $page'
- So, we will try to access other files by inserting a malicious string as the variable parameter to access files located outside the web publish directory.
- Let's try to get the '/etc/passwd' file to get root access rights.
- On the 42 school devices, apache2 is used. So we can deduct that the 'index.php' location would be: '/var/www/html/mynewsite/index.php', and to go up to the '/etc' (which is the folder we are looking for), we should try: '../../../../etc/passwd'
- When accessing the '../../../../etc/passwd' file, a prompt showed up and said 'Almost'. We are not far from the flag.
- To be 100% sure we went up the repositories enough, we put more dot dot slash elements: ../../../../../../../../../../../../../etc/passwd
- The flag appeared: b12c4b2cb8094750ae121a676269aa9e2872d07c06e429d25a63196ec1c8c1d0

##Breach Details 
- Local file inclusion (also known as LFI) is the process of including files that are already locally present on the server by exploiting vulnerable inclusion procedures implemented in the application. 
- This vulnerability occurs, for example, when a page receives, as input, the path to the file that has to be included, and this input is not properly sanitized, allowing directory traversal characters (such as dot-dot-slash) to be injected. 
- A path traversal attack (also known as directory traversal) aims to access files and directories stored outside the webroot folder.
- Path traversal in its simplest form uses the ../ pattern. 
- Every time a resource or file is included by the application, there is a risk that an attacker may be able to have a file or remote resource you didn’t authorize.

Recommendation: 
- Don’t store sensitive configuration files inside the webroot.
- To eliminate file inclusion vulnerabilities, you should avoid passing user-submitted input to any filesystem/framework API to secure the '$page' element.
- It is better to use page 'id' de page, check numeric elements, and compare them in the DB. It will limit the possible entries. Any request containing an invalid identifier will be rejected; in this way, there is no attack surface for malicious users to manipulate the path.
- A rooting system or the verification of the $page content might also work.
Additional resources: https://owasp.org/www-project-web-security-testing-guide/v41/4-Web_Application_Security_Testing/07-Input_Validation_Testing/11.1-Testing_for_Local_File_Inclusion


##How to:
- Visit the page: http://192.168.56.101/?page=../../../../../../../../../../../../../etc/passwd
- The flag is there
