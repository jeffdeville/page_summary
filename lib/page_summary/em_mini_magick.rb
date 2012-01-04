require "em-synchrony"
require 'em-synchrony/em-http'
require 'mini_magick'
require 'ap'

class EmMiniMagick
  def self.load_image(url)
    file = EM::HttpRequest.new(url).get 
    img = case file.response
      when String
        p "string"
        ::MiniMagick::Image.from_blob file.response
      else
        p "stream: #{file.response.class}"
        ::MiniMagick::Image.read file.response
    end
    img
  end
end
