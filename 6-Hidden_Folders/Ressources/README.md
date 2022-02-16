#6-Hidden_Folders Breach

##Research explanation
- Let's load again the robots.txt file and see what we can find with the other path. I loaded the http://192.168.56.101/robots.txt page. 
- I loaded  http://192.168.56.101/.hidden
- A loat of folders and files are there. Based on the several README available it seems a flag is hidden.
- Let's try to scrap all the possible pathes, I tried few tests with wget and it downloaded more than 8K files (Readme and index files mainly) so I stopped it - wget -r -nd -e robots=off "http://192.168.56.101/.hidden/"
- I started again by focusing on one type of files the README files which I downloaded in a specific folder - wget -r -nd -e robots=off -A "README*" "http://192.168.56.101/.hidden/"
- I downloaded 36568 files.
- I designed a python script to open all the files, remove the duplicates and generate a new csv with  all the info of these files.
- In this csv file, the flag is found: 99dde1d35d1fdd283924d84e6d9f1d820


##Breach Details 
- This is not a good practice to hide sensitive data through an important folder tree structure.
- An automatic script is able to scrap all the data easily, and with few retries identify the schema structure which is used.
Recommendation: 
- Don't hide sensitive data on  this kind of storage.
- If you want to keep something hidden, it is better to store it on a secure database or on a local environment.

##How to:
- Load  http://192.168.56.101/.hidden
- Create a folder 'TEST_DARKLY'
- Open this folder in the terminal and download all the README files with: wget -r -nd -e robots=off -A "README*" "http://192.168.56.101/.hidden/"
- Move all
- Run the python script scan_readme.py to generate the csv of all the unique files and find the flag.