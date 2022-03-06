#04_XSRF_Cookie

##Research explanation
- While testing several things for the Leave Feedback breach, we tested several HTML injection, including this one:
\<a onmouseover="alert(document.cookie)"\>xxs link\</a\>
- After the reload of the page, an alert window appears and shows one cookie detail of the website:
I_am_admin=68934a3e9455fa72420237eb05902327
- We can also retrieve the cookie using the browser's developer mode (Application Tab).
- It seems it is a hash. Let's decrypt ut using the dcode hash website -  https://www.dcode.fr/fonction-hash
- It is an MD5 hash retrieving 'false' when decoded.
- Let's try to change the cookie value to 'true'. After encoding it in MD5 using the website, we obtained the below hash:
b326b5062b2f0e69046810717534cb09
- Let's load it on the website. To create a cookie on a website using js: document.cookie = "username=John Doe";
In our case: document.cookie = "I_am_admin=b326b5062b2f0e69046810717534cb09"; which needs to be loaded in the website console.
- After teh reresh of the page, a pop up window apperead:
Good job! Flag : df2eb4ba34ed059a1e3e89ff4dfc13445f104a1a52295214def1c4fb1693a5c3

##Breach Details 
- It is a cross-site request forgery attack.
- Using only cookies to identify yourself to get specific access to a website is not a best practice. It should  be either combined with another way to authenticate yourself (token) or follow the bellow recommendations to avoid issues
- According to OWASP, Web Cookies are often a key attack vector for malicious users (typically targeting other users), and the application should always take due diligence to protect cookies. Cookies can be used for many reasons, such as session management/personalization/tracking. The industry has developed means to help lock down these cookies and limit their attack surface to secure cookie data.

Recommendation: 
- A way to secure a cookie is to use the HttpOnly attribute to help prevent attacks such as session leakage since it does not allow the cookie to be accessed via a client-side script such as JavaScript.
This doesn’t limit the whole attack surface of XSS attacks, as an attacker could still send a request in place of the user but limits immensely the reach of XSS attack vectors.
- Cookies used for sensitive information (such as indicating authentication) should have a short lifetime, with the SameSite attribute set to Strict or Lax. In browsers that support SameSite, this ensures that the authentication cookie isn't sent with cross-site requests. This would make the request effectively unauthenticated to the application server.
- Several  other best practices are available in the OWASP documentation: https://owasp.org/www-project-web-security-testing-guide/latest/4-Web_Application_Security_Testing/06-Session_Management_Testing/02-Testing_for_Cookies_Attributes // https://developer.mozilla.org/en-US/docs/Web/HTTP/Cookies#creating_cookies


##How to:
- Get the cookie info from the Application tab of the developer mode of the browser
- Decode the hash using https://www.dcode.fr/fonction-hash
- Encode in MD5 the word 'true' using https://www.dcode.fr/fonction-hash
- Load the  below js command in the website console:
document.cookie = "I_am_admin=b326b5062b2f0e69046810717534cb09"
- The flag is there

