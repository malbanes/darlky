#10-Client_Side_Validation Breach

##Research explanation
- Let's visit the survey page. On this page we can notice we can vote for people by attributing a grade to people. The grade are between 1 to 10.
- When you add a grade, the average is slowly increasing and the number of vote is incremented by one.
- First, using the developer mode of the browser, I tried to inspect the vote number and check how it was generated. I was trying to force a new ranking by implementing a large amount of votes for Mathieu for example. Maybe a script which could trigger 10000 votes would be an option? But after few investigations, nothing was interesting on the vote number part.
- Then, I came back on the grade part of the code. It was possible to notice that the value of the grade is posted through a simple js form.
- I immediatly tried to change the 'backend' value wich will be sent. So, I looked at Mathieu grades form, I replace the second value <option value="2">2</option> with <option value="99999999999">2</option> and I just selected in the front the '2' value in the form.
- Tha flag appeared.

##Breach Details 
- The value of the form is set on the client side and will be send to the backend without any control or validation.
- This is an important issue (as for the password recovery breach) where a malicious user can change the value which will be sent.
- Let's imagine if on a marketplace website, an article is out of stock, if they are using a similar system to set the value, you could potentially add the product to your cart by increasing the quantity you want even if it is out of stock.

Recommendation: 
- An input validation system would be useful to avoid this breach, if we need to use a value which is set from the client side
- Input validation is performed to ensure only properly formed data is entering the workflow in an information system, preventing malformed data from persisting in the database and triggering malfunction of various downstream components. Input validation should happen as early as possible in the data flow, preferably as soon as the data is received from the external party.
- In our voting system, a backend controller to check if the value is only included in a 1 to 10 range would be able to avoid problems (Minimum and maximum value range check for numerical parameters and dates, minimum and maximum length check for strings).
- Based on the value you need to confirm from the client, here are a lot of options to help you deal with it: https://cheatsheetseries.owasp.org/cheatsheets/Input_Validation_Cheat_Sheet.html
- Additional info: https://cwe.mitre.org/data/definitions/20.html

##How to:
- On the survey page, inspect the page using the developer mode of the browser,
- Select with the mouse selector the 'grade' section for Mathieu
- Replace one of the option in the js form, e.g.  <option value="2">2</option> with <option value="99999999999">2</option>
- Select the value you have changed in the front
- The flag will appear.