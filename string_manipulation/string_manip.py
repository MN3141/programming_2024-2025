#Script for testing python string manipulation on files and directories

import os 
import sys
import subprocess

FILE_INPUT="config.txt"
dir_path=os.path.realpath(__file__).replace(sys.argv[0],"")
old_dir=os.listdir(dir_path)

for index in old_dir:
    #remove files;keep only directories
    if os.path.isdir(index)==False:
        old_dir.remove(index)

print(old_dir)