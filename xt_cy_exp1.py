# Simple python cybersecurity exercises
# Written on: January 23, 2025

# Scenario: You are building a simple Python script that asks the user to input 
# a password and checks if it meets certain security requirements.

# import re

# user_password = input("Please enter a password: ")

# def validate_password(user_password):
#     # Check the length of the password
#     if len(user_password) < 8:
#         return False
    
#     # Check for at least one uppercase letter
#     if not re.search(r'[A-Z]', user_password):
#         return False
    
#     # Check for at least one digit
#     if not re.search(r'\d', user_password):
#         return False
    
#     # Check for at least one special character
#     if not re.compile(r'[^a-zA-Z0-9]', user_password):
#         return False
    
#     return True

# if validate_password(user_password):
#     print("Your password is strong!")
# else:
#     print("Your password is weak. Please choose a stronger password.")


#####################
# Scenario: You are building a user registration form for a website. One of 
# the fields in the form is an email address. Your task is to validate 
# the user input and ensure that it is a properly formatted email address.
######################

# import re

# # Test the validate_email function
# email1 = input("Please enter an email address: ")

# def validate_email(email1):
#     # Email pattern to check for the proper format
#     pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z]+\.[a-zA-Z]{2,}$'
#     # Check if the email matches the pattern
#     if re.match(pattern, email1):
#             return True
#     else:
#             return False

# if validate_email(email1):
#     print("Valid email address.")
# else:
#     print("Invalid email address.")


####################
## Password validation practice
# Written on: January 24, 2025
#####################

# import re

# # password = input("Enter a password: ")

# def is_password_valid(password):
#     if not len(password) >= 8:
#         return False
    
#     if not re.search(r'[a-z]', password): # At least one lower case letter
#         return False
    
#     if not re.search(r'[A-Z]', password): # At least one upper case letter
#         return False
    
#     if not re.search(r'[!@#$%^&*()_+\-=\[\]{};"\\|,.<>\/?~]', password): # At least one special character
#         return False
    
#     if not re.search(r'\d', password): # At lease one digit
#         return False
    
#     if re.search(r'\s', password): # No whitespace character
#         return False
    
#     return True

# print(is_password_valid("Blabl ebl1bl)blu")) # False
# print(is_password_valid("Abs123!s$"))  # True
# print(is_password_valid("123we3"))        # False
# print(is_password_valid("pA^sswo-rd_123")) # True

# if is_password_valid(password):
#     print("Valid password")
# else:
#     print("Not valid password")


#############################
"""
Create a simple password strength checker
Written on January 25, 2025
"""
# import re

# def password_strength(password):
#     if len(password) < 8:
#         return False
    
#     if not re.search('[a-z]', password):
#         return False
    
#     if not re.search('[A-Z]', password):
#         return False
    
#     if not re.search('\d', password):
#         return False
    
#     if not re.search('[!@#$%^&*()_+=<>?/{}]', password):
#         return False
    
#     return True

# print(password_strength("hakewm"))
# print(password_strength("hA2#k9090s"))
# print(password_strength("h kwnsoJL"))
# print(password_strength("0 234PassW0rd"))
# print(password_strength("weakpas"))


"""Write a Python program that defines a function and takes 
a password string as input and returns its SHA-256 hashed 
representation as a hexadecimal string.

With this code, passwords can be securely stored and authenticated 
by hashing them and storing only their hashed representation.
Written on: January 26, 2025"""

# import hashlib

# def hash_password(password):
#     # Encode the password as bytes
#     password_bytes = password.encode('utf-8')

#     # Use SHA-256 hash function to create a hash object
#     hash_object = hashlib.sha256(password_bytes)

#     # Get the hexadecimal representation of the hash
#     password_hash = hash_object.hexdigest()

#     return password_hash

# password = input("Input a password: ")
# hashed_password = hash_password(password)
# print("Your hashed password is: ", hashed_password)


####################
# Hashlib exercise. Similar to the previous exercise above.
# Written on: January 26, 2025
# import hashlib

# def hashed_password(password):
#     # Create a hash object using SHA-256
#     hash_object = hashlib.sha256(password.encode('utf-8'))

#     # Get the hexadecimal digest of the hash
#     hex_digest = hash_object.hexdigest()

#     return hex_digest

# print(hashed_password("hello world"))

##################################
# Generate a random password with a combination of uppercase and 
# lowercase letters, digits, and special characters.
# Written on: January 26, 2025

# import secrets
# import string

# def generate_password(length=12):
#     alphabet = string.ascii_letters + string.digits + string.punctuation
#     return ''.join(secrets.choice(alphabet) for i in range(length))

# password = generate_password()
# print(password)

#### Another attempt ######
# import secrets
# import string

# def random_password(length=12):
#     alphabet = string.ascii_letters + string.digits + string.punctuation
#     return ''.join(secrets.choice(alphabet) for i in range(length))

# print(random_password(20))


###########################################
# Write a Python program that defines a function and takes a password string 
# as input and returns its SHA-256 hashed representation as a hexadecimal string.
# Written on: January 27, 2025
###########################################
# import hashlib

# def hash_pass(password):
#     encode = password.encode('utf-8')

#     hash_object = hashlib.sha256(encode)

#     hex_digest = hash_object.hexdigest()

#     return hex_digest

# print("Your hashed password is ", hash_pass("Hello world"))
# print(hash_pass("January 27, 2025"))
# print(hash_pass("Extra practice"))


##################################
# Generate a random password with a combination of uppercase and 
# lowercase letters, digits, and special characters.
# Written on: January 27, 2025
###################################

# import random
# import string

# def generate_password(length=12):
#     # Define the characters to use in the password
#     alfabet = string.ascii_letters + string.digits + string.punctuation

#     # Use the random module to generate the password
#     password = r''.join(random.choice(alfabet) for i in range(length))

#     return password

# password_length_str = input("Input the desire length of your password: ")

# # Defaults to 12 characters password if there is no input
# if password_length_str:
#     password_length = int(password_length_str)
# else:
#     password_length = 12

# password = generate_password(password_length)
# print(f"Generated password is: {password}")


############################################
# Write a Python program to check if a password meets the following criteria:
# At least 8 characters long and
# Contains at least one uppercase letter, one lowercase letter, one digit, and 
# one special character (!, @, #, $, %, or &)
# If the password meets the criteria, print a message that says "Valid Password." 
# If it doesn't meet the criteria, print a message that says 
# "Password does not meet requirements."
# Written on: January 28, 2025
##############################################

# import re

# def valid_password(password):
#     if len(password) < 8:
#         return False
    
#     if not re.search(r'[a-z]', password):
#         return False
    
#     if not re.search(r'[A-Z]', password):
#         return False
    
#     if not re.search(r'\d', password):
#         return False
    
#     if not re.search(r'[!@#$%&]', password):
#         return False
    
#     return True

# password = input('Input your passowrd: ')
# is_valid = valid_password(password)

# if is_valid:
#     print("Valid Password")
# else:
#     print("Password does not meet requirements.")


###################################################
# Write a Python function that takes a password as input and 
# returns a list of common character substitutions that 
# could be used to create a stronger password.
# Written on: January 29, 2025
################################################
# Practice attempt

# password = input("Input your password: ")

# def get_password_variants(password):
#     pass_variants = []
#     substitutions = {
#         'a': ['@', '4', 'A'],
#         'e': ['3', 'E'],
#         'i': ['1', '!', 'I'],
#         'o': ['0', '0'],
#         's': ['$', '5', 'S'],
#         't': ['7', 'T'],
#         'z': ['2', 'Z']
#     }

#     for i in range(len(password)):
#         if password[i] in substitutions: # Checks whether the character at the current index i of the password exists as a key in the substitutions dictionary
#             for sub in substitutions[password[i]]: # iterates over each element in the list of substitution
#                 pass_variant = password[:i] + sub + password[i+1:] # concatenation
#                 pass_variants.append(pass_variant) # adds generated password variant to the pass_variants list

#     pass_variants.append(password + '!')
#     pass_variants.append(password + '123')
#     pass_variants.append(password + '@')
#     pass_variants.append(password + '#')
#     pass_variants.append(password + '$')
#     pass_variants.append(password + '%')
#     pass_variants.append(password + '&')
#     pass_variants.append(password + '*')
#     pass_variants.append(password + '-')
#     pass_variants.append(password + '_')
#     pass_variants.append(password + '=')
#     pass_variants.append(password + '+')  
#     return pass_variants # Returns the pass_variants list

# result_variants = get_password_variants(password)
# print(result_variants)

#########
### Attempt no.2: February 1, 2025
#########

# password = input("Input your password: ")

# def alt_password(password):
#     # Creates an empty list to input pass_variant
#     variants = []
#     # A substitution dictionary list to substitute each character
#     substitutions = {
#         'a': ['@', '4', 'A'],
#         's': ['3', 'E', '#'],
#         'd': ['I', '1', '|'],
#         'f': ['0', 'O', 'Q', '*'],
#         'j': ['U', '()', '##']
#     }

#     for i in range(len(password)):
#         if password[i] in substitutions:
#             for sub in substitutions[password[i]]:
#                 pass_variant = password[:i] + sub + password[i+1:]
#                 variants.append(pass_variant)
    
#     variants.append(password + 'l4l4l4')
#     variants.append(password + '@9876')
#     variants.append(password + '$A$P')
#     variants.append('--__--'+ password +'****')
#     return variants

# is_variant = alt_password(password)
# print(is_variant)


####################################
# Write a Python function that reads a file containing a list of passwords, one per line.
# It checks each password to see if it meets certain requirements(e.g. at least 8 characters,
# contains both uppercase and lowercase letters, and at least one number and one special
# character.) Passwords that satisfy the requirements should be printed by the program.
# Written on: February 2, 2025
##################################
# For reference
# import re
# def check_password(password):
#     # Define regular expressions for each requirement
#     length_regex = re.compile(r'^.{8,}$')
#     uppercase_regex = re.compile(r'[A-Z]')
#     lowercase_regex = re.compile(r'[a-z]')
#     digit_regex = re.compile(r'\d')
#     special_regex = re.compile(r'[\W_]')
    
#     # Check if password meets each requirement
#     length_check = length_regex.search(password)
#     uppercase_check = uppercase_regex.search(password)
#     lowercase_check = lowercase_regex.search(password)
#     digit_check = digit_regex.search(password)
#     special_check = special_regex.search(password)
    
#     # Return True if all requirements are met, False otherwise
#     if length_check and uppercase_check and lowercase_check and digit_check and special_check:
#         return True
#     else:
#         return False

# # Open file containing passwords
# with open('passwords.txt') as f:
#     # Read each password from file and check if it meets requirements
#     for password in f:
#         password = password.strip()  # Remove newline character
#         if check_password(password):
#             print("Valid Password: "+password)
#         else:
#             print("Invalid Password: "+password)

###################
# Practice session
# Written on: February 6, 2025
####################

# import re

# def pass_requirements(password):
#     # Define regular expression for each requirement
#     len_re = re.compile(r'^.{8,}$')
#     cap_re = re.compile(r'[A-Z]')
#     low_re = re.compile(r'[a-z]')
#     num_re = re.compile(r'\d')
#     spec_re = re.compile(r'[\W_]')

#     # Ensure passwords meet the requirements
#     len_meet = len_re.search(password)
#     cap_meet = cap_re.search(password)
#     low_meet = low_re.search(password)
#     num_meet = num_re.search(password)
#     spec_meet = spec_re.search(password)

#     # If all of the requirements are met, return true, if not, returnFalse
#     if len_meet and cap_meet and low_meet and num_meet and spec_meet:
#         return True
#     else:
#         return False

# with open('passwords.txt') as f:
#     for password in f:
#         password = password.strip()
#         if pass_requirements(password):
#             print("Valid password: "+ password)
#         else:
#             print("Invalid password: " + password)


####################################################
# Write a Python program that reads a file containing 
# a list of usernames and passwords, one pair per line (separatized by a comma). 
# It checks each password to see if it has been leaked in a data breach. You can 
# use the "Have I Been Pwned" API (https://haveibeenpwned.com/API/v3) to check if a 
# password has been leaked.
######################################################
import requests
import hashlib

# Read the file containing usernames and passwords
with open('passwords.txt', 'r') as f:
    for line in f:
        # Split the line into username and passord
        username, password = line.strip().split(',')

        # Hash the password using SHA-1 algorith
        password_hash = hashlib.sha1(password.encode('utf-8')).hexdigest().upper()

        # Make a request to "Have I Been Pwned" API to check if the password has been leaked
        response = requests.get(f'https://api.pwnedpasswords.com/range/{password_hash[:5]}')

        # If the response status code is 200, it means the password has been leaked
        if response.status_code == 200:
            # Get the list of hashes of leaked passwords that start with the same 5 character as the input password
            hashes = [line.split(':') for line in response.text.splitlines()]

            # Check if the hash of the input password matches any of the leaked password hashes
            for h, count in hashes:
                if password_hash[5:] == h:
                    print(f"Password for user {username} has been leaked {count} times.")
                    break
        else:
            print(f"Could not check password for user {username}.")