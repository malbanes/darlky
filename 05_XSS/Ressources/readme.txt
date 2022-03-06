#05_XSS

##Research explanation
- On the main page, there is the last call to action at the bottom of the page - 'Leave A Feedback'
- On the next page, there are 2 fields you can fill to leave a comment on the website. We did several tests with words and SQL commands to try to identify a potential breach. We also investigated the developer feature of the browser (HTML structure, queries sent when we press 'submit'). Nothing exciting
- After a few pieces of research on the OWASP website, we checked the Client-Side Testing OWASP potential breaches, and we chose to focus on the HTML injection testing
(https://owasp.org/www-project-web-security-testing-guide/latest/4-Web_Application_Security_Testing/11-Client-side_Testing/)
- It showed that sometimes forms are not protected enough and can read and execute the HTML tags (similar to the XSS attack in the NSA Prism JPG breach). So we tried to load several HTML tags to see how it goes, based on the example in  the OWASP  article: https://owasp.org/www-project-web-security-testing-guide/latest/4-Web_Application_Security_Testing/11-Client-side_Testing/03-Testing_for_HTML_Injection
ex: <b>Hello</b>
with the above example, the name is bold, and the body automatically removes the tags.
As we had difficulties adding long HTML queries inside the fields, we changed the 'maxlength' HTML restriction using the browser's developer mode.
All the tags seem identified but do not let me access the flag.
- We continued the investigation on the OWASP website, and we finished finding an interesting possible breach related to HTML injection combined with malformed tags:  https://cheatsheetseries.owasp.org/cheatsheets/XSS_Filter_Evasion_Cheat_Sheet.html
- We tried several commands, including this one, which help find another breach \<a onmouseover="alert(document.cookie)"\>xxs link\</a\>.
- The command which worked is a malformed 'a' tag including only this element: 'a' 
- The flag appeared: 0FBB54BBF7D099713CA4BE297E1BC7DA0173D8B3C21C1811B916A3A86652724E

##Breach Details 
- Again, it is an XSS breach with HTML code injection where tags or script tags can be used to execute code.
- The fields were not protected enough against HTML code executions. It was possible to execute code with well-formatted tags (C.f. cookie display), and with a malformed tag, it triggered the flag. Maybe it is to show we need to be careful with both well-formatted HTML execution and malformed HTML execution, because sometimes the browsers can reinterpret malformed tags (according to OWASP documentation)

Recommendation: 
- HTML Encode Before Inserting Untrusted Data into HTML Element Content:Encode the following characters for example (&, <, >, ", ') with HTML entity encoding to prevent switching into any execution context, such as script, style, or event handlers. Using hex entities is recommended in the spec.
- Libraries that can parse and clean HTML formatted text are available to help sanitize data. For example, HtmlSanitizer is a .NET library for cleaning HTML fragments and documents from constructs that lead to an XSS attack.
- Additional  official recommendations: https://cheatsheetseries.owasp.org/cheatsheets/Cross_Site_Scripting_Prevention_Cheat_Sheet.html

##How to:
- Input 'a' in the name and message fields
- Press 'Sign GuestBook'
- The flag is there