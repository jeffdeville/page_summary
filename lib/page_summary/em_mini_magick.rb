require "em-synchrony"
require 'em-synchrony/em-http'
require 'mini_magick'

module PageSummary
  class EmMiniMagick
    def self.load_image(url)
      url = URI.parse(url) if url.is_a? String

      tries = 0
      while true
        request = EM::HttpRequest.new(url).get
        case request.response_header.status
          when 200
            return ::MiniMagick::Image.read request.response if request.response_header.status == 200
          when 301, 302 then
            url = request.response_header['location']
          when 404 then
            raise HTTP404, url
          when 0
            tries += 1 # If a network error occurred, try again up to 3 times
            raise HTTPNetworkError, url if tries == 3
          else
            raise StandardError, "Something went wrong, but I don't know what. #{request.response_header.status}"
        end
      end




    end
  end
end
