require "em-synchrony"
require 'em-synchrony/em-http'
require 'mini_magick'

class EmMiniMagick
  def self.load_image(url)
    file = EM::HttpRequest.new(url).get 
    img = ::MiniMagick::Image.read file.response 
  end
end
