#12_XSS_Bypass_filter

##Research explanation
- We continue our investigation on the main home page. 
- By checking the assets used for this main page, an interesting thing was identified: on the 3 first images available,  only one (the last NSA blue logo) is redirecting to another page displaying the "File: nsa_prism.jpg".
There is nothing really interesting on this page, but the URL "http://192.168.56.101/?page=media&src=nsa" shows a possible breach. It uses a query string with the URL. 
- We tried to replace the src query with another word as "test", or "admin". It just showed me a flag was there, but we did not do the right thing to find it.
- We started to inspect the page with the developer feature of the browser. On this simple page, we found an interesting HTML tag. The 'object' tag seems to be triggered when the page is loaded. This is a well-known XSS vector and is considered a site-authoring bug. You can inject 'script' or 'iframe' tags with an object tag. This is something we should try.
- So, we directly tried to put a js script in the URL after the 'src' element - <script>  alert('Trying to load some code'); </script> - but it did not worked. When you check the network developer panel, you can see that all the special characters of the script are converted to URL readable characters.
- After a few pieces of research, it is possible to load data from the URL using 'Data url' type: "Data URLs are composed of four parts: a prefix (data:), a MIME type indicating the type of data, an optional base64 token if non-textual, and the data itself"
- If you don't put the optional base64 token, some extra code might be loaded but you still don't have access to the flag:
src=data:text/html,<script>%20%20alert(%27Trying%20to%20load%20some%20code%27);%20</script>
- It is required to convert the <script>  alert('Trying to load some code'); </script> line and encode it in base64: PHNjcmlwdD4gIGFsZXJ0KCdUcnlpbmcgdG8gbG9hZCBzb21lIGNvZGUnKTsgPC9zY3JpcHQ+
- Then, if you load the page with this src element: http://192.168.56.101/?page=media&src=data:text/html;base64,PHNjcmlwdD4gIGFsZXJ0KCdUcnlpbmcgdG8gbG9hZCBzb21lIGNvZGUnKTsgPC9zY3JpcHQ+, the flag appears.


##Breach Details 
- This type of injection attack occurs when the input and output are not correctly validated. Therefore the main rule to prevent HTML attacks is appropriate data validation.
- Every input should be checked if it contains any script code or HTML code.
- This attack is called an XSS filter attack.

Recommendation: 
- Avoid using data received from the client for client-side sensitive actions such as rewriting or redirection. 
- The image display should be stored in a DB with the image name and its host link instead of implementing everything to interact directly with the HTML code.
- Use intrusion prevention systems to inspect inbound URL parameters and prevent inappropriate pages from being served.


##How to:
- Encode a js script piece of code into Base64
- Replace the end of the URL: the 'nsa' source with this: src=data:text/html;base64, + the encoded js script
src=data:text/html;base64,PHNjcmlwdD4gIGFsZXJ0KCdUcnlpbmcgdG8gbG9hZCBzb21lIGNvZGUnKTsgPC9zY3JpcHQ+
- Press enter
- The flag is there

Breach links:
- https://cheatsheetseries.owasp.org/cheatsheets/XSS_Filter_Evasion_Cheat_Sheet.html
- https://bugzilla.mozilla.org/show_bug.cgi?id=530308
- https://pentest-tools.com/blog/xss-attacks-practical-scenarios
Base64 links:
- https://www.codeproject.com/Tips/82794/Embedded-HTML-Help-File-with-Images
- https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/Data_URIs
- https://base64.guru/developers/html/object
- https://www.onlineutility.in/base64_Decode_Online