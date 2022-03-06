#13_Hidden_Folders

##Research explanation
- Let's load the robots.txt file again and see what we can find with the other path. We loaded the http://192.168.56.101/robots.txt page. 
- We loaded http://192.168.56.101/.hidden
- A lot of folders and files are there. Based on the several README available, it seems a flag is hidden.
- Let's try to scrape all the possible paths, we tried a few tests with wget, and it downloaded more than 8K files (Readme and index files mainly), so we stopped it - wget -r -nd -e robots=off "http://192.168.56.101/.hidden/"
- We started again by focusing on one type of files the README files, which we downloaded in a specific folder - wget -r -nd -e robots=off -A "README*" "http://192.168.56.101/.hidden/"
NB: -r = Turn on recursive retrieving // -nd = Do not create a hierarchy of directories when retrieving recursively // -e robots=off = to allow the wget command and hide it is a script // -A "README*" = accept the file with the name starting by README 
- We downloaded 36568 files.
- We designed a python script to open all the files, remove the duplicates and generate a new CSV with all the info of these files.
- In this csv file, the flag is found: 99dde1d35d1fdd283924d84e6d9f1d820


##Breach Details 
- This is not a good practice to hide sensitive data through an important folder tree structure.
- An automatic script can scrape all the data quickly and, with few retries, identify the schema structure used.

Recommendation: 
- Don't hide sensitive data on this kind of storage.
- If you want to keep something hidden, it is better to store it on a secure database or in a local environment.


##How to:
- Load http://192.168.56.101/.hidden
- Create a folder 'TEST_DARKLY'
- Open this folder in the terminal and download all the README files with: wget -r -nd -e robots=off -A "README*" "http://192.168.56.101/.hidden/"
- Move all
- Run the python script scan_readme.py to generate the CSV of all the individual files and find the flag.