# CLI response
data = cli_response

# Regular expression search
import re
search_pattern = re.compile(r'''
    ^         # Search from the beginning of the line
    (\D+      # Start match group 1, match 1 or more non-digits
    \s        # Match a single space character
    \D+)      # Match 1 or more non-digits, end match group 1
    ([0-9]    # Start match group 2, match any single digit
    \/        # Match a single forward slash
    [0-9]{2}) # Match any two digits, end match group 2
    \n        # Match the end of the line
    ''',
    re.VERBOSE
)

search_result = search_pattern.search(data)

try:
    interface_name = search_result.group(2)
except AttributeError:
    pass
