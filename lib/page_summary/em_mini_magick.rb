#require "em-synchrony"
#require 'em-synchrony/em-http'
require 'mini_magick'

module PageSummary
  class EmMiniMagick
    extend EmDownloader

    def self.load_image(url)
      load_from_url(url) do |request|
        return ::MiniMagick::Image.read request.response if request.response_header.status == 200
      end
    end
  end
end
