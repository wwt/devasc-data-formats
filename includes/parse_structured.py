# API response
data = api_data['rpc_reply']

# Extract the interface name
try:
    interface_name = data['acl']['interfaces']['interface']['id']
except KeyError as e:
    import sys
    print(f'Error occurred - {e!r}', file=sys.stderr)
