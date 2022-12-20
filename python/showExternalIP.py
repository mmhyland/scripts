#!/usr/bin/python3

import urllib.request

external_ip = urllib.request.urlopen('https://ident.me').read().decode('utf8')
print(f"External IP: {external_ip}")