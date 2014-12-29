require 'json'

module RubyHlrClient
  class HlrCallbackHandler

    # Parses an asynchronous HLR Lookup callback and returns a JSON string with the results.
    # @param params
    # @returns {*}
    #
    # Return example: {"success":true,"results":[{"id":"40ebb8d9e7cc","msisdncountrycode":"DE","msisdn":"+491788735001","statuscode":"HLRSTATUS_DELIVERED","hlrerrorcodeid":null,"subscriberstatus":"SUBSCRIBERSTATUS_CONNECTED","imsi":"262032000000000","mccmnc":"26203","mcc":"262","mnc":"03","msin":"2000000000","servingmsc":"491770","servinghlr":null,"originalnetworkname":"178","originalcountryname":"Germany","originalcountrycode":"DE","originalcountryprefix":"+49","originalnetworkprefix":"178","roamingnetworkname":null,"roamingcountryname":null,"roamingcountrycode":null,"roamingcountryprefix":null,"roamingnetworkprefix":null,"portednetworkname":null,"portedcountryname":null,"portedcountrycode":null,"portedcountryprefix":null,"portednetworkprefix":null,"isvalid":"Yes","isroaming":"No","isported":"No","usercharge":"0.0100","inserttime":"2014-12-28 05:53:03.765798+08","storage":"ASYNC-API","route":"IP4"}]}
    def parse_callback(params)

      unless params.has_key?('json')
        return generate_error_result('Invalid callback parameters. Missing json payload.')
      end

      params['json']

    end

    def send_response

      'OK'

    end

    def generate_error_result(message)

      result = {:success => false, :fieldErrors => [], :globalErrors => ["#{message}"]}
      result.to_json

    end

  end

end
