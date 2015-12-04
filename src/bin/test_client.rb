#!/usr/bin/env ruby

require 'ruby_hlr_client/hlr_client'

# Initializes the HLR Lookup Client
# @param username - www.hlr-lookups.com username
# @param password - www.hlr-lookups.com password
# @param ssl - set to false to disable SSL
# @constructor
client = RubyHlrClient::HlrClient.new(
    'username',
    'password'
)
print "\n"

# Submits a synchronous HLR Lookup request. The HLR is queried in real time and results presented in the response body.
# @param msisdn - An MSISDN in international format, e.g. +491788735000
# @param route - An optional route assignment, see: http://www.hlr-lookups.com/en/routing-options
# @param storage - An optional storage assignment, see: http://www.hlr-lookups.com/en/storages
# @returns string (JSON)
#
# Return example: {"success":true,"results":[{"id":"e1fdf26531e4","msisdncountrycode":"DE","msisdn":"+491788735000","statuscode":"HLRSTATUS_DELIVERED","hlrerrorcodeid":null,"subscriberstatus":"SUBSCRIBERSTATUS_CONNECTED","imsi":"262031300000000","mccmnc":"26203","mcc":"262","mnc":"03","msin":"1300000000","servingmsc":"140445","servinghlr":null,"originalnetworkname":"E-Plus","originalcountryname":"Germany","originalcountrycode":"DE","originalcountryprefix":"+49","originalnetworkprefix":"178","roamingnetworkname":"Fixed Line Operators and Other Networks","roamingcountryname":"United States","roamingcountrycode":"US","roamingcountryprefix":"+1","roamingnetworkprefix":"404455","portednetworkname":null,"portedcountryname":null,"portedcountrycode":null,"portedcountryprefix":null,"portednetworkprefix":null,"isvalid":"Yes","isroaming":"Yes","isported":"No","usercharge":"0.0100","inserttime":"2014-12-28 06:22:00.328844+08","storage":"SDK-TEST-SYNC-API","route":"IP1"}]}
print client.submit_sync_lookup_request('+491788735000', 'IP4', 'SDK-TEST')
print "\n\n"

# Submits a synchronous number type lookup request. Results are presented in the response body.
# @param number - An number in international format, e.g. +4989702626
# @param route - An optional route assignment, see: http://www.hlr-lookups.com/en/routing-options
# @param storage - An optional storage assignment, see: http://www.hlr-lookups.com/en/storages
# @returns string (JSON)
#
# Return example: { "success":true, "results":[ { "id":"2ed0788379c6", "number":"+4989702626", "numbertype":"LANDLINE", "state":"COMPLETED", "isvalid":"Yes", "ispossiblyported":"No", "isvalidshortnumber":"No", "isvanitynumber":"No", "qualifiesforhlrlookup":"No", "originalcarrier":null, "mccmnc":null, "mcc":null, "mnc":null, "countrycode":"DE", "region":"Munich", "timezones":[ "Europe\/Berlin" ], "infotext":"This is a landline number.", "usercharge":"0.0050", "inserttime":"2015-12-04 10:36:41.866283+00", "storage":"SYNC-API-NT-2015-12", "route":"LC1" } ] }
print client.submit_sync_number_type_lookup_request('+4989702626', 'LC1', 'SDK-TEST')
print "\n\n"

# Sets the callback URL for asynchronous lookups. Read more about the concept of asynchronous HLR lookups @ http://www.hlr-lookups.com/en/asynchronous-hlr-lookup-api
# @param url - callback url on your server
# @returns string (JSON)
#
# Return example: {"success":true,"messages":[],"results":{"url":"http:\/\/user:pass@www.your-server.com\/path\/file"}}
print client.set_async_callback_url('http://user:pass@www.your-server.com/path/file')
print "\n\n"

# Sets the callback URL for asynchronous number type lookups.
# @param url - callback url on your server
# @returns string (JSON)
#
# Return example: {"success":true,"messages":[],"results":{"url":"http:\/\/user:pass@www.your-server.com\/path\/file"}}
print client.set_nt_async_callback_url('http://user:pass@www.your-server.com/path/file')
print "\n\n"

# Submits asynchronous HLR Lookups containing up to 1,000 MSISDNs per request. Results are sent back asynchronously to a callback URL on your server. Use \VmgLtd\HlrCallbackHandler to capture them.
# @param msisdns - A list of MSISDNs in international format, e.g. +491788735000
# @param route - An optional route assignment, see: http://www.hlr-lookups.com/en/routing-options
# @param storage - An optional storage assignment, see: http://www.hlr-lookups.com/en/storages
# @returns string (JSON)
#
# Return example: {"success":true,"messages":[],"results":{"acceptedMsisdns":[{"id":"e489a092eba7","msisdn":"+491788735000"},{"id":"23ad48bf0c26","msisdn":"+491788735001"}],"rejectedMsisdns":[],"acceptedMsisdnCount":2,"rejectedMsisdnCount":0,"totalCount":2,"charge":0.02,"storage":"SDK-TEST-ASYNC-API","route":"IP4"}}
print client.submit_async_lookup_request(['+491788735000', '+491788735001'])
print "\n\n"

# Submits asynchronous number type lookups containing up to 1,000 numbers per request. Results are sent back asynchronously to a callback URL on your server.
# @param numbers - A list of numbers in international format, e.g. +4989702626,+491788735000
# @param route - An optional route assignment, see: http://www.hlr-lookups.com/en/routing-options
# @param storage - An optional storage assignment, see: http://www.hlr-lookups.com/en/storages
# @returns string (JSON)
#
# Return example: { "success":true, "messages":[], "results":{ "acceptedNumbers":[ { "id":"f09b30014d5e", "number":"+4989702626" }, { "id":"364c0ad33c02", "number":"+491788735000" } ], "rejectedNumbers":[ { "id":null, "number":"asdf" } ], "acceptedNumberCount":2, "rejectedNumberCount":1, "totalCount":3, "charge":0.01, "storage":"ASYNC-API-NT-2015-12", "route":"LC1" } }
print client.submit_async_number_type_lookup_request(['+4989702626','+491788735000'])
print "\n\n"

# Returns the remaining balance (EUR) in your account.
# @returns string (JSON)
#
# Return example: {"success":true,"messages":[],"results":{"balance":"5878.24600"}}
print client.get_balance
print "\n\n"

# Performs a health check on the system status, the user account and availability of each route.
# @returns string (JSON)
#
# Return example: { "success":true, "results":{ "system":{ "state":"up" }, "routes":{ "states":{ "IP1":"up", "ST2":"up", "SV3":"up", "IP4":"up", "XT5":"up", "XT6":"up", "NT7":"up", "LC1":"up" } }, "account":{ "lookupsPermitted":true, "balance":"295.23000" } } }
print client.do_health_check
print "\n"