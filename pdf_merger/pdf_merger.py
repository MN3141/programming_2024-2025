#Script for mering PDF files
#Store the files in the input_files directory
#in order for the script to work

import os
from PyPDF2 import PdfMerger

input_files_dir=os.getcwd()+"\\input_files\\"
merger = PdfMerger()
files =os.listdir(input_files_dir)
for file in files:
    merger.append(input_files_dir+file)

merger.write("output.pdf")
merger.close()
print("Mergin done!")