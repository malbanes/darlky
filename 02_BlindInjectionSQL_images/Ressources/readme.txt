#7-Search_Image Breach

##Research explanation
- On the main page, there is another call to action called "Search Image".

- On vérifie que la faille est exploitable en cherchant une différence entre un résultats valide et invalide. 
1 and 1=1 retourne bien un élément (true état) et 1 and 1=2 ne retourne rien (false état)
- On the next page, we can see there is another serach field. Let see if it is protected or not agains SQL injections. Let's use the SQL command to get again the DB structure (the one use to find the 4th flag - Search Member): 1 UNION SELECT TABLE_NAME, COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS
- Let's query the 'list_images' table using the different available fields:
id, url, title, comment.
- When I used this SQL query: 1 UNION SELECT title, comment FROM list_images 
it was possible to notice one image which is containing:
ID: 1 UNION SELECT title, comment FROM list_images 
Title: If you read this just use this md5 decode lowercase then sha256 to win this flag ! : 1928e8083cf461a51303633093573c46
Url : Hack me ?
- I decripted the hash, using the dcode hash website -  https://www.dcode.fr/fonction-hash
=> 1928e8083cf461a51303633093573c46 : albatroz
- Then I aply a Sh256 encryption on the 'albatroz' key and I got this flag:
f2a29020ef3132e01dd61df97fd33ec8d7fcd1388cc9601e7db691d17d4d6188

##Breach Details 
- SQL injection is a commun breach (especially on PHP app).
- It is an: insertion or “injection” of a SQL query via the input data from the client to the application. A successful SQL injection exploit can read sensitive data from the database, modify database data (Insert/Update/Delete), execute administration operations on the database (such as shutdown the DBMS), recover the content of a given file present on the DBMS file system and in some cases issue commands to the operating system.
- According to OWASP, an SQL injection attacks allow attackers to spoof identity, tamper with existing data, cause repudiation issues such as voiding transactions or changing balances, allow the complete disclosure of all data on the system, destroy the data or make it otherwise unavailable, and become administrators of the database server.

Recommendation: 
- SQL Injection flaws are introduced when software developers create dynamic database queries that include user supplied input. To avoid SQL injection flaws is simple. Developers need to either: 
a) stop writing dynamic queries; and/or 
b) prevent user supplied input which contains malicious SQL from affecting the logic of the executed query.
Some solutions: The use of prepared statements with variable binding (aka parameterized queries) is a suitable solution. Parameterized queries force the developer to first define all the SQL code, and then pass in each parameter to the query later. This coding style allows the database to distinguish between code and data, regardless of what user input is supplied. Input validation can be also a good defense used to detect unauthorized input before it is passed to the SQL query. 

##How to:
- Input '1 UNION SELECT TABLE_NAME, COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS' in the search image field
- Input '1 UNION SELECT title, comment FROM list_images ' in the search image field
- Decode the hash using 'https://www.dcode.fr/fonction-hash'
- Lower the word obtained and encrypt it with sh256 on the same website
- The flag is there.