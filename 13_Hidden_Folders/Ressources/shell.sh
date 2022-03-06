which -s brew
if [[ $? != 0 ]] ; then
    echo "Installing Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo "Installing Python Packages"
    brew install python3
    python3 -m pip install pandas
    python3 -m pip install pathlib
    brew install wget
    echo "Prepare folder"
    mkdir "TEST_DARKLY"
    cd "TEST_DARKLY"
    echo "Download readme files"
    wget -r -nd -e robots=off -A "README*" "http://192.168.56.101/.hidden/"
    cd ..
    echo "Extract flag"
    python3 scan_readme.py
    echo "END"
else
    echo "Updating Homebrew"
    brew update
    echo "Installing Python Packages"
    brew install python3
    python3 -m pip install pandas
    python3 -m pip install pathlib
    brew install wget
    echo "Prepare folder"
    mkdir "TEST_DARKLY"
    cd "TEST_DARKLY"
    echo "Download readme files"
    wget -r -nd -e robots=off -A "README*" "http://192.168.56.101/.hidden/"
    cd ..
    echo "Extract flag"
    python3 scan_readme.py
    echo "END"
fi