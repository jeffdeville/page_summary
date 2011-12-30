require 'mechanize'
require 'em-synchrony'
require 'em-synchrony/em-http'

class EmMechanize
  def self.load_url(url)
    response = EM::HttpRequest.new(url).get()
    p "started the get for #{url}"
    response.callback { p "callback fired"; EventMachine.stop } if defined? VCR
    p "callback set up"
    if response.response_header.status == 200 
      mech = Mechanize.new

      response.response_header["content-type"] = response.response_header["CONTENT_TYPE"]
      p response.req.uri
      p response.response_header
      # p response.response
      page = Mechanize::Page.new(response.req.uri, response.response_header, response.response, 200, mech)
      return page
    end
    p "Well that sucked..."
    
  end
end
