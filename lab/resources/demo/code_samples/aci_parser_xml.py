#!/usr/bin/env python3
""" Commands to demonstrate parsing an ACI token from an APIC XML login
    response.
"""

# Import module for REST API calls and disable certificate warnings
import requests
requests.packages.urllib3.disable_warnings()

# Define APIC URL, credentials, and authentication payload
url = 'https://sandboxapicdc.cisco.com/api/aaaLogin.xml'
name = 'admin'
pwd = 'ciscopsdt'
data = f'<aaaUser name="{name}" pwd="{pwd}" />'

# Authenticate to the APIC
login_response = requests.post(
    url=url,
    data=data,
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
# token_pattern = re.compile(r'(token=")(.+?)("\w?)')

# Option #2, verbose syntax (preferred)
token_pattern = re.compile(r'''
    (token=")   # Group #1: the literal string, 'token="'
    (.+?)       # Group #2: first instance of everything between groups #1 & #3
    ("\w?)      # Group #3: first instance of a " followed by a space character
    ''',
    re.VERBOSE


 Perform a regex search on the APIC response text
token_search = token_pattern.search(login_response.text)

# Regex match group 2 should be the token so, display the value for group 2
print(token_search.group(2))

# Assign the token in match group 2 to a new variable, named 'token'
token = token_search.group(2)

# Display the value for the 'token' variable
print(token)

# Simplify the token parsing from the APIC response with structured JSON data

# Import the 'xmltodict' module (requires PyPi installation)
import xmltodict

# Convert the XML text APIC response to a Python dictionary
xml_response = xmltodict.parse(  # The parse method converts XML to Python data
    login_response.text,         # XML value to convert to Python
    dict_constructor=dict        # Use 'dict' instead of default 'OrderedDict'
)

# Display the response object dictionary with the Pretty Print module/method
from pprint import pprint
pprint(xml_response)

# Extract the token from the response dictionary and assign it to 'token'
token = xml_response['imdata']['aaaLogin']['@token']

# Display the value for the 'token variable
print(token)
