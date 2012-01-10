require 'mechanize'
require 'em-synchrony'
require 'em-synchrony/em-http'

module PageSummary
  class HTTP404 < StandardError
  end
  class HTTPNetworkError < StandardError
  end

  class EmMechanize
    def self.load_url(url)
      tries = 0
      while true
        response = EM::HttpRequest.new(url).get
        case response.response_header.status
          when 200
            mech = Mechanize.new
            response.response_header["content-type"] = response.response_header["CONTENT_TYPE"]
            page = Mechanize::Page.new(response.req.uri, response.response_header, response.response, 200, mech)
            return page
          when 301, 302
            url = response.response_header['location']
          when 404
            raise HTTP404, url
          when 0
            # If a network error occurred, try again up to 3 times
            tries += 1
            raise HTTPNetworkError, url if tries == 3
          else
            raise StandardError, "Something went wrong, but I don't know what. #{response.response_header.status}"
        end
      end
    end
  end
end