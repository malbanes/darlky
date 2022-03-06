#!/usr/bin/env python
# -*-coding: utf-8 -*

import sys
import re
import pandas as pd
import pathlib

def main():
    sumUp = pd.DataFrame(columns=['file', 'content'])

    for path in pathlib.Path("TEST_DARKLY").iterdir():
        if path.is_file():
            mylines = []  
            current_file = open(path, "r")
            #print(current_file.read())
            for myline in current_file:
                mylines.append(myline)  
                print(mylines)
            df = {'file': str(path), 'content': str(mylines)}
            print(df)
            sumUp = sumUp.append(df, ignore_index=True)
            current_file.close()
    print(sumUp)
    sumUp = sumUp.drop_duplicates(subset='content', keep="last")
    sumUp.to_csv("RESULT.csv", sep=',')

if __name__ == "__main__":
    main()