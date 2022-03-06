#14_Client_Side_Validation 

##Research explanation
- Let's visit the survey page. We can notice we can vote for people by attributing a grade to people on this page. The grades are between 1 to 10.
- When you add a grade, the average slowly increases, and the number of votes is incremented by one.
First, we tried to inspect the vote number and check how it was generated using the browser's developer mode. We were trying to force a new ranking by implementing many votes for Mathieu. Maybe a script that could trigger 10000 votes would be an option? But after a few investigations, nothing was interesting on the vote number part.
- Then, we came back to the grade part of the code. It was possible to notice that the grade's value is posted through a simple js form.
- We immediatly tried to change the 'backend' value wich will be sent. So, we looked at Mathieu grades form, we replaced the second value <option value="2">2</option> with <option value="99999999999">2</option> and we just selected in the front the '2' value in the form.
- The flag appeared.

##Breach Details 
The form's value is set on the client-side and will be sent to the backend without any control or validation.
- This is an important issue (as for the password recovery breach) where a malicious user can change the value sent.
- Let's imagine if, on a marketplace website, an article is out of stock, if they are using a similar system to set the value, you could potentially add the product to your cart by increasing the quantity you want even if it is out of stock.

Recommendation: 
- An input validation system would be helpful to avoid this breach if we need to use a value that is set from the client-side
- Input validation is performed to ensure only properly formed data is entering the workflow in an information system, preventing malformed data from persisting in the database and triggering malfunction of various downstream components. Input validation should happen as early as possible in the data flow, preferably as soon as the external party receives the data.
- In our voting system, a backend controller to check if the value is only included in a 1 to 10 range would be able to avoid problems (Minimum and maximum value range check for numerical parameters and dates, minimum and maximum length check for strings).
- Based on the value you need to confirm from the client, here are a lot of options to help you deal with it: https://cheatsheetseries.owasp.org/cheatsheets/Input_Validation_Cheat_Sheet.html
- Additional info: https://cwe.mitre.org/data/definitions/20.html

##How to:
- On the survey page, inspect the page using the developer mode of the browser,
- Select with the mouse selector the 'grade' section for Mathieu
- Replace one of the option in the js form, e.g. <option value="2">2</option> with <option value="99999999999">2</option>
- Select the value you have changed in the front
- The flag is there