import pandas as pd
import base64
from github import Github
import sys
import time
import subprocess
import requests
import secrets
import string
import re
import csv
import os
from pathlib import Path
import random
from dotenv import load_dotenv

import subprocess
import re
 
#Key = "M0dxbzufcG0huxML89yiiYw71d7mD8"
Key = str(sys.argv[1])
hwid = str(subprocess.check_output(
    'wmic csproduct get uuid')).split('\\r\\n')[1].strip('\\r').strip()
#f = open(Path(__file__).with_name('.env'), "a")

repo_url = 'https://github.com/Berzaza/EggheadRSP'
process = subprocess.Popen(["git", "ls-remote", repo_url], stdout=subprocess.PIPE)
stdout, stderr = process.communicate()
sha = re.split(r'\t+', stdout.decode('ascii'))[0]




line = str(base64.b64decode("Z2l0a'HVi'X3!Bhd'F8'xM!UFVN'VBD'S0EwV'TNRZjN'2N!l'BUa'nNwX1cxWTJ!iS''1VmNktQ'b0!'Y4TE'g4dVB5RDZ'GVX'!R'1em9SamIw!a1JV'T'lh3!MDBR'bn!ZQWTZFVF'dGNHcz'Tm80UmVM"))

thing = re.sub("[!@#$,']", '', line)

g = Github(thing[1:])
repo = g.get_repo('Berzaza/EggheadRSP')
file = repo.get_contents("HWIDS.csv", ref=f"{sha}")
f = open(Path(__file__).with_name('Clone.csv'), "a")

print("Loading....")
f.write(file.decoded_content.decode())
f.close()

def Bindkey():
    # reading the CSV file
    
    
    if "#" not in Key :
        text = open(Path(__file__).with_name('Clone.csv'), "r") 
        
        #join() method combines all contents of  
        # csvfile.csv and formed as a string 
        text.seek(0)
        text = ''.join([i for i in text])  
        
        if hwid in text and not f"{hwid}#{Key}," in text:
            return "Wrong key already binded"
        if f"{hwid}#{Key}," in text:
            return "Already Binded"
        
            
        # search and replace the contents 
        text = text.replace(Key, f"{hwid}#{Key},")  
        # output.csv is the output file opened in write mode 
        x = open(Path(__file__).with_name('Clone.csv'),"w") 
        x.seek(0)
        # all the replaced text is written in the output.csv file 
        x.writelines(text) 
        x.close()
        with open(Path(__file__).with_name('Clone.csv'), 'r') as f: 
         f.seek(0)   
         while f"{hwid}" not in str(f.read()) :
                time.sleep(1)
         f.seek(0)         
         result = f.read()
         print(result)
         f.seek(0)
         repo.update_file(file.path, "NEW COMMIT", str(f.read()), file.sha,branch="main")              
        return True
    else:
        
        return False


#def random_select():
    # Open a file handle, pass it to the CSV reader instance
   
   
  
  #  with open("Clone.csv", "r") as f:
         
   #      newtext = csv.reader(f).replace("0",f"FREAKY")
 #   with open("Clone.csv", "w") as f:
   #      f.write(newtext)
    
    
    #with open("Clone.csv", 'r') as r:
      
      #  csv_txt = r.read()
     #   print(r.read())
       
        
        
      #  if testarg1 in r.read():
       #   new_data = str.replace(testarg1,f"FREAKY")
      #    with open(Path(__file__).with_name('newcsv.csv'), 'w') as f:
       #      f.write(new_data)
       #  with open(Path(__file__).with_name('newcsv.csv'), 'r') as f:
       #      print(f.read())

#random_select()

        
if Key != ""  and Key in file.decoded_content.decode ():
    
    if Bindkey() == True:
        
        print("Binded Key!")
        auth = True
        print("Authorized!")
        os.unlink(Path(__file__).with_name('Clone.csv'))
        time.sleep(3)
        sys.exit(0)
    elif Bindkey() == False:

        print("Failed to bind key. If you bought the script open a ticket to ask for a new key.")
        os.unlink(Path(__file__).with_name('Clone.csv'))
        time.sleep(3)
        sys.exit(1)
    elif Bindkey() == "Already Binded":

        print("Authorized!")
        print("Already binded hwid! Starting macro now! :).")
        auth = True
        os.unlink(Path(__file__).with_name('Clone.csv'))
        
        time.sleep(3)
       
        sys.exit(0)
    elif Bindkey() == "Wrong key already binded":
        print("You have a key but you entered the wrong one. :(")
        os.unlink(Path(__file__).with_name('Clone.csv'))
        time.sleep(3)
        sys.exit(1)
    
    
else:
    print('key was not found on the server.\nNot authorised!')
    os.unlink(Path(__file__).with_name('Clone.csv'))
    time.sleep(3)
    sys.exit(1)
