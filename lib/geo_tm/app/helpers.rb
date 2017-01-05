module GeoTM
  class App < Sinatra::Base
    module Helpers
      def payload
        return params unless params == {}
        request.body.rewind
        JSON.parse(request.body.read).deep_symbolize_keys
      rescue
        {}
      end
    end
  end
end
