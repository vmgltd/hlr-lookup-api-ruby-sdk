#!/usr/bin/env ruby
require 'ruby_hlr_client/client'

# This file contains examples on how to interact with the HLR Lookup API.
# All endpoints of the API are documented here: https://www.hlr-lookups.com/en/api-docs

# Create an HLR Lookups API client
# The constructor takes your API Key, API Secret and an optional log file location as parameters
# Your API Key and Secret can be obtained here: https://www.hlr-lookups.com.com/en/api-settings

client = HlrLookupsSDK::Client.new(
    'YOUR-API-KEY',
    'YOUR-API-SECRET',
    '/var/log/hlr-lookups-api.log' # an optional log file location
)

# Invoke a request to GET /auth-test (https://www.hlr-lookups.com/en/api-docs#get-auth-test) to see if everything worked
response = client.get('/auth-test')

# The API returns an HTTP status code of 200 if the request was successfully processed, let's have a look.
print "Status Code: " + response.code.to_s + "\n"
print "Response Body: " + response.body + "\n"

# Submit an HLR Lookup via POST /hlr-lookup (https://www.hlr-lookups.com/en/api-docs#post-hlr-lookup)
response = client.post('/hlr-lookup', msisdn: '+905536939460')

print "HLR Lookup Status Code: " + response.code.to_s + "\n"
print "HLR Lookup Response Body: " + response.body + "\n"

if response.code != 200
  # something went wrong
  print "Received non-OK status code from server." + "\n"
end

# do something with the HLR data
data = JSON.parse(response.body)

# Submit an NT Lookup via POST /nt-lookup (https://www.hlr-lookups.com/en/api-docs#post-nt-lookup)
response = client.post('/nt-lookup', number: '+905536939460')

print "NT Lookup Status Code: " + response.code.to_s + "\n"
print "NT Lookup Response Body: " + response.body + "\n"

if response.code != 200
  # something went wrong
  print "Received non-OK status code from server." + "\n"
end

# do something with the NT data
data = JSON.parse(response.body)

# Submit an MNP Lookup via POST /mnp-lookup (https://www.hlr-lookups.com/en/api-docs#post-mnp-lookup)
response = client.post('/mnp-lookup', msisdn: '+905536939460')

print "MNP Lookup Status Code: " + response.code.to_s + "\n"
print "MNP Lookup Response Body: " + response.body + "\n"

if response.code != 200
  # something went wrong
  print "Received non-OK status code from server." + "\n"
end

# do something with the NT data
data = JSON.parse(response.body)