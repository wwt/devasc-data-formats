#!/usr/bin/env python

valid_file = False

with open('my_file.txt', mode='rt', encoding='utf-8') as file:
    contents = file.read()
    if "Hello World" in contents.capitalize():
        valid_file = True

if valid_file:
    print('File is valid\n'
          f'Contents = {contents}')
else:
    print('File is not valid')
