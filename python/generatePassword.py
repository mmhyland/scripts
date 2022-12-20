#!/usr/bin/python3

import string
from random import *

length = int(input("Enter password length: "))
characters = string.ascii_letters + string.punctuation  + string.digits
password =  "".join(choice(characters) for x in range(length))

print(f"\n{password}")