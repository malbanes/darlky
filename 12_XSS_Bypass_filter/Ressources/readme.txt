#2-NSA_Prism_JPG breach

##Research explanation
- I continue my investigation on the main home page. 
- By checking the assets used for this main page, an interesting thing was identified: on the 3 first images available,  only one (the last NSA blue logo) is redirecting to another page which is displaying the "File: nsa_prism.jpg".
- Nothing really interesting on this page, but the url "http://192.168.56.101/?page=media&src=nsa" is  showing a possible  breach. It is using a query  string with the url. 
- I tried  to replace the src query with another word as "test", or "admin". It just showed me a flag was there but I did not do the right thing to find it.
- I started to inspect the page with the developer feature of my browser. On this simple page I found an interesting html tag. The 'object' tag seems to be triggered when the page is loaded. This is a well-known XSS vector and is considered a site-authoring bug. With an object tag, you can inject 'script' or 'iframe' tags. This is something we should try.
- So, I directly tried to put a js script in the url after the 'src' element - <script>  alert('Trying to load some code'); </script> - but it did not worked. When you check the network developer panel you can see that all the special characters of the script are converted to url readable characters.
- After few researches, it is possible to load data from the url using 'Data url' type: "Data URLs are composed of four parts: a prefix (data:), a MIME type indicating the type of data, an optional base64 token if non-textual, and the data itself"
- If you don't put the optional base64 token, some extra code might be loaded but you still  don't have access to the flag:
src=data:text/html,<script>%20%20alert(%27Trying%20to%20load%20some%20code%27);%20</script>
- It is required to convert the <script>  alert('Trying to load some code'); </script> line and encode it in base64: PHNjcmlwdD4gIGFsZXJ0KCdUcnlpbmcgdG8gbG9hZCBzb21lIGNvZGUnKTsgPC9zY3JpcHQ+
- Then, if you load the page with this src element: http://192.168.56.101/?page=media&src=data:text/html;base64,PHNjcmlwdD4gIGFsZXJ0KCdUcnlpbmcgdG8gbG9hZCBzb21lIGNvZGUnKTsgPC9zY3JpcHQ+, the flag appeared.

##Breach Details 
- This type of injection attack occurs when the input and output are not properly validated. Therefore the main rule to prevent HTML attack is appropriate data validation.
- Every input should be checked if it contains any script code or any HTML code.
- This attack is  called  a DOM XSS attack.

Recommendation: 
- Avoid using data received from the client for client-side sensitive actions such as rewriting or redirection. 
- The image display should be stored in a DB with the image name and its host link, instead of implementing everything to interact directly with the html code.
- Use intrusion prevention systems that are able to inspect inbound URL parameters and prevent the inappropriate pages to be served.

##How to:
- Encode a js script piece of code into Base64
- Replace the end of the url: the 'nsa' source with this: src=data:text/html;base64, + the encoded js script
src=data:text/html;base64,PHNjcmlwdD4gIGFsZXJ0KCdUcnlpbmcgdG8gbG9hZCBzb21lIGNvZGUnKTsgPC9zY3JpcHQ+
- Press enter


src=data:text/html;base64,PHNjcmlwdD4gYWxlcnQoIkhlbGxvLCBJJ20gdHJ5aW5pbmcgdG8gbG9hZCBzb21lIGNvZGUiKTsgPC9zY3JpcHQ+IA==
Breach links:
- https://owasp.org/www-community/attacks/DOM_Based_XSS
- https://bugzilla.mozilla.org/show_bug.cgi?id=530308
- https://pentest-tools.com/blog/xss-attacks-practical-scenarios
Base64 links:
- https://www.codeproject.com/Tips/82794/Embedded-HTML-Help-File-with-Images
- https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/Data_URIs
- https://base64.guru/developers/html/object
- https://www.onlineutility.in/base64_Decode_Online