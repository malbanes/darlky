#09_CRFL

##Research explanation
When I arrived on the website's main page, I started to check the first redirection link of the buttons available.
- I started with the "SIGN IN" button, which redirected me to a login page, where I tried to input a fake username and a fake password. It did not work.
- Then, I clicked on the "I forgot my password" button. Nothing was visible except the "Submit" button. If you click on it, an error is raised.
- So, I started to inspect the page with the developer feature of my browser, no suitable elements were available on the 'Network'  inspector. 
- So, I checked the HTML file structure. A very interesting thing was there. An unencoded email - "webmaster@borntosec.com" - was there. I changed it to put my personal email and see if something would work; maybe the password would be sent through email. I pressed the "Submit" button, and the flag appeared.


##Breach Details 
- The Password recovery pages are really sensitive.
- It is not a best practice to put sensitive data, like emails, on the webpage code.
- In this specific situation, the available email might be targeted by phishing attacks.
The HTML value field would also be used to redirect the reset password email to another email address.
adding a cc to email with 
%0ACc: Your_Email
- The name of this type of breach is called Carriage Return Line Feed or CRLF - https://owasp.org/www-community/vulnerabilities/CRLF_Injection
- Depending on how the application is developed, this can be a minor problem or a fairly serious security flaw. 
Server Side Injection occurs when an attacker inserts the CRLF characters in an input field to deceive the server by making it think that an object has terminated and a new one has begun when the web application doesn’t sanitize user input for CRLF characters.
- 

Recommendation: 
- If this page is used to recover "Admin" passwords, for example, it could be hidden thanks to restricted access through a specific  IP.
- If external users use this page, an empty email field should be available on the front. When the email is filled, it will check if the user exists in the DB and send an email  (NB: It is usually recommended to not through a specific error message if the user is not identified in the DB + a captcha system could be used to protect you from spam and password decryption by asking you to complete a simple test that proves you are human and not a computer trying to break into a password-protected account).
- Also, to avoid CRFL, sanitizing and neutralizing all user-supplied data or properly encoding output in HTTP headers that would otherwise be visible to users to prevent the injection of CRLF sequences and their consequences is a good thing to do.

 
##How to:
- Go to the "Sign In" page
- Press the "I forgot my password" button
- Inspect the HTML part of the "Submit" button
- Change the value of this "<input type="hidden" name="mail" value="webmaster@borntosec.com" maxlength="15">" line with your email address
- Press the "Submit" button
- The flag is there