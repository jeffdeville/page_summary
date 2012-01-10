require 'em-synchrony'
require 'em-synchrony/em-http'

module PageSummary
  class HTTP404 < StandardError
  end
  class HTTPNetworkError < StandardError
  end

  module EmDownloader
    def load_from_url(url)
      url = URI.parse(url) if url.is_a? String
      tries = 0
      while true
        response = EM::HttpRequest.new(url).get
        case response.response_header.status
          when 200
            #mech = Mechanize.new
            response.response_header["content-type"] = response.response_header["CONTENT_TYPE"]
            yield response
            return
          #page = Mechanize::Page.new(response.req.uri, response.response_header, response.response, 200, mech)
          #return page
          when 301, 302 then
            url = response.response_header['location']
          when 404 then
            raise HTTP404, url
          when 0
            tries += 1 # If a network error occurred, try again up to 3 times
            raise HTTPNetworkError, url if tries == 3
          else
            raise StandardError, "Something went wrong, but I don't know what. #{response.response_header.status}"
        end
      end
    end
  end
end