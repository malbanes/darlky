#8-Leave_Feedback Breach

##Research explanation
- On the main page, there is a last call to action at the bottom of the page - 'Leave A Feedback'
- On the  next page, there are 2 fields you can fill to leave a comment on the website. I did several tests with words and sql commands, to try identify a potential breach. I also investigated with the developer feature of my browser (html structure, queries sent when we press 'submit'). Nothing really interesting
- After few researches on the OWASP website, I checked the Client-Side Testing OWASP potential breaches, and I chose to focus on the HTML injection testing
(https://owasp.org/www-project-web-security-testing-guide/latest/4-Web_Application_Security_Testing/11-Client-side_Testing/)
- It showed that sometimes forms are not enough protected and can read and execute the html tags (similar to the XSS attack in the NSA Prism JPG breach). So I tried to load several html tags to see how it goes, based on the exemple in  the OWASP  article: https://owasp.org/www-project-web-security-testing-guide/latest/4-Web_Application_Security_Testing/11-Client-side_Testing/03-Testing_for_HTML_Injection
ex: <b>Hello</b>
with the above example, the name is in bold, and the body is automatically removing the tags.
- As I had difficulties to add long html queries inside the fields, I changed the 'maxlength' html resctiction using the developer mode of the browser.
- All the tags seems identified but are not let me get an access to the flag.
- I continued my  investigation on the OWASP website and I finished to find an interesting possible breach related to html injection combine with malformed tags:  https://cheatsheetseries.owasp.org/cheatsheets/XSS_Filter_Evasion_Cheat_Sheet.html
- I tried several commands, including this one, which help find another breach \<a onmouseover="alert(document.cookie)"\>xxs link\</a\>.
- The command which worked is a malformed 'a' tag including only this element: '<a' 
- The flag appeared: 0FBB54BBF7D099713CA4BE297E1BC7DA0173D8B3C21C1811B916A3A86652724E

##Breach Details 
- It is again an xss breach with html code injection where a tags or script tags can be used to execute code.
- The fields were not enough protected against html code executions. It was possible to execute code with well formated tags (C.f. cookie display), and with a malfomated tag it triggered the flag. Maybe it is to show we need to be careful with both well-formated html execution and malformated html execution, because sometimes the browsers are able to reinterpret malformated tags (according to OWASP documentations)

Recommendation: 
- HTML Encode Before Inserting Untrusted Data into HTML Element Content:Encode the following characters for example (&, <, >, ", ') with HTML entity encoding to prevent switching into any execution context, such as script, style, or event handlers. Using hex entities is recommended in the spec.
- Libraries that can parse and clean HTML formatted text are available to help sanitize data. For example, HtmlSanitizer is a .NET library for cleaning HTML fragments and documents from constructs that can lead to XSS attack.
- Additional  official recomendations: https://cheatsheetseries.owasp.org/cheatsheets/Cross_Site_Scripting_Prevention_Cheat_Sheet.html

##How to:
- Input '<a'in the name and message fields
- Press 'Sign GuestBook'
- The flag appears