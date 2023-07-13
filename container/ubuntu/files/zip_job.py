
import os
import sys
import zipfile

#
# if you want to verif that script stop create the following file
# touch a.txt
# chmod 0000 a.txt
# in this scenario the python will not be able to create a.txt and will
# throw exception 
#
#ubuntu@ip-172-31-49-191:~/git/my-code-example/container/ubuntu/files/z$ python3 zip_job.py
#[FATAL] Exception raise while creating files
#ubuntu@ip-172-31-49-191:~/git/my-code-example/container/ubuntu/files/z$ ls -la



#
#


# Array of characters
characters = [chr(i) for i in range(ord('a'), ord('z') + 1)]

# Create zip files
version = os.getenv("VERSION")

def pack_text_file_into_zip(text_file_path, zip_file_path):
    with zipfile.ZipFile(zip_file_path, 'w') as zip_file:
        zip_file.write(text_file_path)

if not version:
    print("Error: VERSION environment variable not set.")
    sys.exit(1)


# Create txt files
try:
  for char in characters:
      file_name = f"{char}.txt"
      with open(file_name, 'w') as file:
          file.write("Hello world")
except Exception as e:
  print("[FATAL] Exception raise while creating files")
  sys.exit(1)

# Create zip

try:
  for char in characters:
      pack_text_file_into_zip(f"{char}.txt", f"{char}_{version}.zip")
except Exception as e:
  print("[FATAL Exception raise while creating zip files")
  sys.exit(1)
