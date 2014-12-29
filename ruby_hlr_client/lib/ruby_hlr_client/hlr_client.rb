require 'rest_client'

module RubyHlrClient

  class HlrClient

    # Initializes the HLR Lookup Client
    # @param username - www.hlr-lookups.com username
    # @param password - www.hlr-lookups.com password
    # @param ssl - set to false to disable SSL
    # @constructor
    def initialize(username, password, ssl = true)
      @username = username
      @password = password
      @url = "#{ssl ? 'https' : 'http'}://www.hlr-lookups.com/api"
    end

    # Submits a synchronous HLR Lookup request. The HLR is queried in real time and results presented in the response body.
    # @param msisdn - An MSISDN in international format, e.g. +491788735000
    # @param route - An optional route assignment, see: http://www.hlr-lookups.com/en/routing-options
    # @param storage - An optional storage assignment, see: http://www.hlr-lookups.com/en/storages
    # @returns string (JSON)
    #
    # Return example: {"success":true,"results":[{"id":"e1fdf26531e4","msisdncountrycode":"DE","msisdn":"+491788735000","statuscode":"HLRSTATUS_DELIVERED","hlrerrorcodeid":null,"subscriberstatus":"SUBSCRIBERSTATUS_CONNECTED","imsi":"262031300000000","mccmnc":"26203","mcc":"262","mnc":"03","msin":"1300000000","servingmsc":"140445","servinghlr":null,"originalnetworkname":"E-Plus","originalcountryname":"Germany","originalcountrycode":"DE","originalcountryprefix":"+49","originalnetworkprefix":"178","roamingnetworkname":"Fixed Line Operators and Other Networks","roamingcountryname":"United States","roamingcountrycode":"US","roamingcountryprefix":"+1","roamingnetworkprefix":"404455","portednetworkname":null,"portedcountryname":null,"portedcountrycode":null,"portedcountryprefix":null,"portednetworkprefix":null,"isvalid":"Yes","isroaming":"Yes","isported":"No","usercharge":"0.0100","inserttime":"2014-12-28 06:22:00.328844+08","storage":"SDK-TEST-SYNC-API","route":"IP1"}]}
    def submit_sync_lookup_request(msisdn, route = nil, storage = nil)

      params = {
        :action => 'submitSyncLookupRequest',
        :msisdn => msisdn,
        :username => @username,
        :password => @password
      }

      unless route.nil?
        params.merge!(route: route)
      end

      unless storage.nil?
        params.merge!(storage: storage)
      end

      send_request(params)

    end

    # Submits asynchronous HLR Lookups containing up to 1,000 MSISDNs per request. Results are sent back asynchronously to a callback URL on your server. Use \VmgLtd\HlrCallbackHandler to capture them.
    # @param msisdns - A list of MSISDNs in international format, e.g. +491788735000
    # @param route - An optional route assignment, see: http://www.hlr-lookups.com/en/routing-options
    # @param storage - An optional storage assignment, see: http://www.hlr-lookups.com/en/storages
    # @returns string (JSON)
    #
    # Return example: {"success":true,"messages":[],"results":{"acceptedMsisdns":[{"id":"e489a092eba7","msisdn":"+491788735000"},{"id":"23ad48bf0c26","msisdn":"+491788735001"}],"rejectedMsisdns":[],"acceptedMsisdnCount":2,"rejectedMsisdnCount":0,"totalCount":2,"charge":0.02,"storage":"SDK-TEST-ASYNC-API","route":"IP4"}}
    def submit_async_lookup_request(msisdns, route = nil, storage = nil)

      params = {
          :action => 'submitAsyncLookupRequest',
          :msisdns => msisdns_to_string(msisdns),
          :username => @username,
          :password => @password
      }

      unless route.nil?
        params.merge!(route: route)
      end

      unless storage.nil?
        params.merge!(storage: storage)
      end

      send_request(params)

    end

    # Sets the callback URL for asynchronous lookups. Read more about the concept of asynchronous HLR lookups @ http://www.hlr-lookups.com/en/asynchronous-hlr-lookup-api
    # @param url - callback url on your server
    # @returns string (JSON)
    #
    # Return example: {"success":true,"messages":[],"results":{"url":"http:\/\/user:pass@www.your-server.com\/path\/file"}}
    def set_async_callback_url(url)

      send_request({
        :action => 'setAsyncCallbackUrl',
        :url => url,
        :username => @username,
        :password => @password
      })

    end

    # Returns the remaining balance (EUR) in your account.
    # @returns string (JSON)
    #
    # Return example: {"success":true,"messages":[],"results":{"balance":"5878.24600"}}
    def get_balance

      send_request({
        :action => 'getBalance',
        :username => @username,
        :password => @password
      })

    end

    def send_request(params)

      response = RestClient.get @url, :params => params

      unless response.code == 200
        return generate_error_result("HTTP Status Code #{response.code}")
      end

      response.to_str

    end

    def generate_error_result(message)

      {:success => false, :fieldErrors => [], :globalErrors => ["#{message}"]}.to_json

    end

    def msisdns_to_string(msisdns)

      string = ''
      c = 0
      msisdns.each { |msisdn|

        if c > 0
          string += ','
        end

        string += msisdn

        c = c+1

      }

      string

    end

  end

end
