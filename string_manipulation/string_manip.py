#Script for testing python string manipulation on files and directories

import os 
import sys
import subprocess

FILE_INPUT="config.txt"

def get_dir():
    dir_path=os.path.realpath(__file__).replace(sys.argv[0],"")
    old_dir=os.listdir(dir_path)

    for index in old_dir:
        #remove files;keep only directories
        if os.path.isdir(index)==False:
            old_dir.remove(index)

    return old_dir[0]

def generate_new_dir():

    '''
    input file structure:
    Build no.
    Architecture+Derivative
    Major
    Minor
    Revision
    '''

    fin=open(FILE_INPUT)
    configs=fin.readlines()
    fin.close()

    #remove \n characters
    for i in range(0,len(configs)):

        if(len(configs[i])>1):
            configs[i]=configs[i][:-1]

    new_dir_name="Os_TS_D"+configs[1]+"_M"

    if configs[2]=='0':#major version=0
        new_dir_name=new_dir_name+configs[3]+"I"+configs[4]+"R"+configs[0]
    else:
       new_dir_name=new_dir_name+configs[2]+configs[3]+"I"+configs[4]+"R"+configs[0] 

    return new_dir_name

def change_naming(old_name,new_name):

    git_command="git mv "+ old_name+" "+new_name
    subprocess.run(git_command)

old_dir=get_dir()
new_dir=generate_new_dir()
change_naming(old_dir,new_dir)