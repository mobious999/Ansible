#! /usr/bin/python 
from passlib.hash import sha512_crypt
import getpass
print sha512_crypt.encrypt(getpass.getpass())
