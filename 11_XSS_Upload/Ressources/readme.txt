#11_XSS_Upload

##Research explanation
- At the bottom of the main webpage, there is a page to upload images
- We will try to inject some unwanted code through this upload system
- First, we tested if the upload system verifies the file type we are uploading. To do it, we used a dummy PHP script - bidon.php
- It did not work.
- Then we tried to fake it, faking the file type: bidon64.php.jpg
- This time, it worked - '/tmp/bidon64.php.jpg successfully uploaded' - but we are not able to access the file - 'url/tmp/bidon64.php.jpg'
- So, based on all these learnings, we will try to force the 'PHP' type to 'jpg', using curl command (spoof)
- When the -F option is used, 'curl' sends the data using the multipart/form-data Content-Type, and this is the used format by the form
- We will also add the required elements to post the form, i.e., file, maxFileSize, and Upload + to send a file using the curl command, we need to use '@'
- To let the webiste think we have uploaded a .jpg file, we are forcing the 'MimeType' to '.jpg' instead of '.php'.
We were able to specify the 'content-type' for a part we uploaded by adding ";type=image/jpg.". 
NB: To make the bellow command work, replace the PHP script path with the one it is.
--------------------------------------------
curl -X POST -F 'uploaded=@bidon.php;type=image/jpg' -F 'MAX_FILE_SIZE=100000' -F 'Upload=Upload' 'http://192.168.56.101//index.php?page=upload' | grep 'flag'
--------------------------------------------
- When the command is posted, we finally get the flag:
46910d9ce35b385885a9f7e2b336249d622f29b267a1771fbacf52133beddba8


##Breach Details 
- It is an XSS attack.
- Many applications’ business processes allow users to upload data to them. Although input validation is widely understood for text-based input fields, it is more complicated to implement when accepted files. Although many sites implement simple restrictions based on a list of permitted (or blocked) extensions, this is not sufficient to prevent attackers from uploading legitimate file types that have malicious contents.
- It is a widespread breach, where a blog or forum allows users to upload images and other media files. While these are considered safe, if an attacker can upload executable code (such as a PHP script), this could allow them to execute operating system commands, read and modify information in the filesystem, access the back-end database, and fully compromise the server.

Recommendation: 
- To avoid this kind of attack, the file types allowed to be uploaded should be restricted to only those necessary for business functionality.
- You can also isolate the loaded files in a dedicated separate folder to reduce the bouncing risk when it is a malicious file.
- Files should be thoroughly scanned and validated before being made available to other users. If in doubt, the file should be discarded.
- File uploaders should be only accessible to authenticated and authorized users if possible.
- Rename the uploaded file and use an algorithm to determine the filenames. For instance, a filename can be an MD5 hash of the file's name plus the date of the day. The hacker will have difficulties finding his file again.
- Change also the access rights on the file it is also a good practice - 'chmod()'
In our case, to check if it was an image, we could use the PHP function 'getSize(img) in the back-end. If it was false, the uploaded file was not an image. 
Additional ressources:
https://owasp.org/www-community/vulnerabilities/Unrestricted_File_Upload
https://cheatsheetseries.owasp.org/cheatsheets/File_Upload_Cheat_Sheet.html
https://owasp.org/www-project-web-security-testing-guide/latest/4-Web_Application_Security_Testing/10-Business_Logic_Testing/09-Test_Upload_of_Malicious_Files


##How to:
- In the Terminal, post the below command:
------------------
curl -X POST -F 'uploaded=@bidon.php;type=image/jpg' -F 'MAX_FILE_SIZE=100000' -F 'Upload=Upload' 'http://192.168.56.101//index.php?page=upload' | grep 'flag'
------------------
NB: To make the bellow command work, replace the PHP script path with the one it is.
- The flag is there