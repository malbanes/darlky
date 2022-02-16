#1-Password_Recovery breach:

##Research explanation
- When I arrived on the main page of the website, I started to check the first redirection link of the buttons available.
- I started with the "SIGN IN" button, which redirected me to a login page, where i tried to input a fake username and a fake password. It did not worked.
- Then I clicked on "I forgot my password" button. Nothing  was visible  except "Submit" button. If you click on it, an error is raised.
- So, I started to inspect the page with the developer feature of my browser, no suitable elements were available on the 'Network'  inspector. 
- So I checked the html file structure. A very interesting thing was there. An unencoded email - "webmaster@borntosec.com" - was there.  I changed it  to put my personal email and see  if something  would work, maybe the password would be sent through email. I press the "Submit" button and the flag appeared.


##Breach Details 
- The Password  recovery pages are really sensitive pages.
- It is  not a best practice to put sensitive data, as emails, on the webpage code.
- In this specific situation, the available email might be target by phishing attacks.
- Also, the html value field would be used to redirect the reset password email to another email address.
Recommendation: If this  page is used to  recover "Admin" passwords, for example it could be hidden thanks to  a resticted access through a specific  IP.
If this page is used by external users, an empty email field should be available on the frontend. When the email is filled it will check if the user is existing in the db and send an email  (NB: It is usually recommend to  not through a specific error message if the user is not identified in  the DB + a captcha system could be used to protect you from spam and password decryption by asking you to complete a simple test that proves you are human and not a computer trying to break into a password protected account).
 
##How to:
- Go to "Sign In" page
- Press "I forgot my password" button
- Inspect the html part of the "Submit" button
- Change the value of this "<input type="hidden" name="mail" value="webmaster@borntosec.com" maxlength="15">" line with your email address
- Press "Submit" button