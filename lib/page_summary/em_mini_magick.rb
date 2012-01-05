require "em-synchrony"
require 'em-synchrony/em-http'
require 'mini_magick'
require 'ap'

class EmMiniMagick
  def self.load_image(url)
    file = EM::HttpRequest.new(url).get
    ::MiniMagick::Image.read file.response if file.response_header.status == 200
  end
end
