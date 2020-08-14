# HLR Lookups SDK (Ruby)

Official HLR Lookup API SDK for Ruby by www.hlr-lookups.com. Obtain live mobile phone connectivity and portability data from network operators directly.

This SDK implements the REST API documented at https://www.hlr-lookups.com/en/api-docs and includes an [HLR API](https://www.hlr-lookups.com/en/api-docs#post-hlr-lookup) (live connectivity), [NT API](https://www.hlr-lookups.com/en/api-docs#post-nt-lookup) (number types), as well as an [MNP API](https://www.hlr-lookups.com/en/api-docs#post-mnp-lookup) (mobile number portability).

For SDKs in different programming languages, see https://www.hlr-lookups.com/en/api-docs#sdks

Requirements
------------
* Ruby >= 2.0.0
* rest-client >= 2.1.0
* json >= 1.8.3

Installation with gem
---------------------
`gem install ruby_hlr_client`

**Usage Client**
```ruby
require 'ruby_hlr_client/client'

client = HlrLookupsSDK::Client.new(
    'YOUR-API-KEY',
    'YOUR-API-SECRET',
    '/var/log/hlr-lookups-api.log' # an optional log file location
)
```
Get your API key and secret [here](https://www.hlr-lookups.com/en/api-settings).

## Examples

**Test Authentication** (https://www.hlr-lookups.com/en/api-docs#get-auth-test)

Performs an authenticated request against the `GET /auth-test` endpoint. A status code of 200 indicates that you were able to authenticate using you [API credentials](https://www.hlr-lookups.com/en/api-settings#authSettings).

```ruby
response = client.post('/auth-test')
print "Status Code: " + response.code.to_s + "\n"
print "Response Body: " + response.body + "\n"
```

Get your API key and secret [here](https://www.hlr-lookups.com/en/api-settings).

**Submitting an HLR Lookup** ([HLR API Docs](https://www.hlr-lookups.com/en/api-docs#post-hlr-lookup))

```ruby
response = client.post('/hlr-lookup', msisdn: '+905536939460')

print "HLR Lookup Status Code: " + response.code.to_s + "\n"
print "HLR Lookup Response Body: " + response.body + "\n"

if response.code != 200
  # something went wrong
  print "Received non-OK status code from server."
end

# do something with the HLR data
data = JSON.parse(response.body)
```

The HLR API Response Object:

```json
{
   "id":"f94ef092cb53",
   "msisdn":"+14156226819",
   "connectivity_status":"CONNECTED",
   "mccmnc":"310260",
   "mcc":"310",
   "mnc":"260",
   "imsi":"***************",
   "msin":"**********",
   "msc":"************",
   "original_network_name":"Verizon Wireless",
   "original_country_name":"United States",
   "original_country_code":"US",
   "original_country_prefix":"+1",
   "is_ported":true,
   "ported_network_name":"T-Mobile US",
   "ported_country_name":"United States",
   "ported_country_code":"US",
   "ported_country_prefix":"+1",
   "is_roaming":false,
   "roaming_network_name":null,
   "roaming_country_name":null,
   "roaming_country_code":null,
   "roaming_country_prefix":null,
   "cost":"0.0100",
   "timestamp":"2020-08-07 19:16:17.676+0300",
   "storage":"SYNC-API-2020-08",
   "route":"IP1",
   "processing_status":"COMPLETED",
   "error_code":null,
   "data_source":"LIVE_HLR"
}
```

A detailed documentation of the attributes and connectivity statuses in the HLR API response is [here](https://www.hlr-lookups.com/en/api-docs#post-hlr-lookup).

**Submitting a Number Type (NT) Lookup** ([NT API Docs](https://www.hlr-lookups.com/en/api-docs#post-nt-lookup))

```ruby
response = client.post('/nt-lookup', number: '+905536939460')

print "NT Lookup Status Code: " + response.code.to_s + "\n"
print "NT Lookup Response Body: " + response.body + "\n"

if response.code != 200
  # something went wrong
  print "Received non-OK status code from server."
end

# do something with the NT data
data = JSON.parse(response.body)
```

The NT API Response Object:

```json
{
     "id":"2ed0788379c6",
     "number":"+4989702626",
     "number_type":"LANDLINE",
     "query_status":"OK",
     "is_valid":true,
     "invalid_reason":null,
     "is_possibly_ported":false,
     "is_vanity_number":false,
     "qualifies_for_hlr_lookup":false,
     "mccmnc":null,
     "mcc":null,
     "mnc":null,
     "original_network_name":null,
     "original_country_name":"Germany",
     "original_country_code":"DE",
     "regions":[
        "Munich"
     ],
     "timezones":[
        "Europe/Berlin"
     ],
     "info_text":"This is a landline number.",
     "cost":"0.0050",
     "timestamp":"2015-12-04 10:36:41.866283+00",
     "storage":"SYNC-API-NT-2015-12",
     "route":"LC1"
}
```

A detailed documentation of the attributes and connectivity statuses in the NT API response is [here](https://www.hlr-lookups.com/en/api-docs#post-nt-lookup).

**Submitting an MNP Lookup (Mobile Number Portability)** ([MNP API Docs](https://www.hlr-lookups.com/en/api-docs#post-mnp-lookup))

```ruby
response = client.post('/mnp-lookup', msisdn: '+905536939460')

print "MNP Lookup Status Code: " + response.code.to_s + "\n"
print "MNP Lookup Response Body: " + response.body + "\n"

if response.code != 200
  # something went wrong
  print "Received non-OK status code from server."
end

# do something with the NT data
data = JSON.parse(response.body)
```

The MNP API Response Object:

```json
{
   "id":"e428acb1c0ae",
   "msisdn":"+14156226819",
   "query_status":"OK",
   "mccmnc":"310260",
   "mcc":"310",
   "mnc":"260",
   "is_ported":true,
   "original_network_name":"Verizon Wireless:6006 - SVR/2",
   "original_country_name":"United States",
   "original_country_code":"US",
   "original_country_prefix":"+1415",
   "ported_network_name":"T-Mobile US:6529 - SVR/2",
   "ported_country_name":"United States",
   "ported_country_code":"US",
   "ported_country_prefix":"+1",
   "extra":"LRN:4154250000",
   "cost":"0.0050",
   "timestamp":"2020-08-05 21:21:33.490+0300",
   "storage":"WEB-CLIENT-SOLO-MNP-2020-08",
   "route":"PTX",
   "error_code":null
}
```

A detailed documentation of the attributes and connectivity statuses in the MNP API response is [here](https://www.hlr-lookups.com/en/api-docs#post-mnp-lookup).

API Documentation
-----------------
Please inspect https://www.hlr-lookups.com/en/api-docs for detailed API documentation or email us at service@hlr-lookups.com.

Support and Feedback
--------------------
We appreciate your feedback! If you have specific problems or bugs with this SDK, please file an issue on Github. For general feedback and support requests, email us at service@hlr-lookups.com.

Contributing
------------

1. Fork it ( https://github.com/vmgltd/hlr-lookup-api-ruby-sdk/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request