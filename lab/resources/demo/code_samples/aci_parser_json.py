#!/usr/bin/env python3
""" Commands to demonstrate parsing an ACI token from an APIC JSON login
    response.
"""

# Import module for REST API calls and disable certificate warnings
import requests
requests.packages.urllib3.disable_warnings()

# Define APIC URL, credentials, and authentication payload
url = 'https://sandboxapicdc.cisco.com/api/aaaLogin.json'
name = 'admin'
pwd = 'ciscopsdt'
json = {
    'aaaUser': {
        'attributes': {
            'name': name,
            'pwd': pwd
        }
    }
}

# Authenticate to the APIC
login_response = requests.post(
    url=url,
    json=json,
    verify=False,
    timeout=5
)

# Display HTTP status code and reason
print(f'{login_response.status_code} {login_response.reason}')

# Display APIC response
print(login_response.text)

# Display the unstructured APIC response object type
print(type(login_response.text))

# Since the APIC response is a string, import the regex module
import re

# Create a regex search string to extract the token from the APIC response

# Option #1, standard syntax
# token_pattern = re.compile(r'("token":")(.+?)(","?)')

# Option #2, verbose syntax (preferred)
token_pattern = re.compile(r'''
    ("token":") # Group #1: the literal string, '"token":"'
    (.+?)       # Group #2: first instance of everything between groups #1 & #3
    (","?)      # Group #3: first instance of the literal string, ","
    ''',
    re.VERBOSE
)

# Perform a regex search on the APIC response text
token_search = token_pattern.search(login_response.text)

# Regex match group 2 should be the token so, display the value for group 2
print(token_search.group(2))

# Assign the token in match group 2 to a new variable, named 'token'
token = token_search.group(2)

# Display the value for the 'token' variable
print(token)

# Simplify the token parsing from the APIC response with structured JSON data

# Convert the JSON-formatted APIC response to a Python dictionary
json_response = login_response.json()

# Display the APIC structured response object type
print(type(json_response))

# Display the response object dictionary with the Pretty Print module/method
from pprint import pprint
pprint(json_response)

# Extract the token from the response dictionary and assign it to 'token'
token = json_response['imdata'][0]['aaaLogin']['attributes']['token']

# Display the value for the 'token variable
print(token)
