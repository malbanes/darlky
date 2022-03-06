which -s brew
if [[ $? != 0 ]] ; then
    echo "Installing Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo "Installing Python Packages"
    brew install python3
    python3 -m pip install pandas
    python3 -m pip install pathlib
    mkdir "TEST_DARKLY"
    cd "TEST_DARKLY"
    wget -r -nd -e robots=off -A "README*" "http://192.168.56.101/.hidden/"
    cd ..
    python3 scan_readme.py
else
    echo "Updating Homebrew"
    brew update
    echo "Installing Python Packages"
    brew install python3
    python3 -m pip install pandas
    python3 -m pip install pathlib
    mkdir "TEST_DARKLY"
    cd "TEST_DARKLY"
    wget -r -nd -e robots=off -A "README*" "http://192.168.56.101/.hidden/"
    cd ..
    python3 scan_readme.py
fi