require 'mechanize'
require 'em-synchrony'
require 'em-synchrony/em-http'

module PageSummary
  class EmMechanize
    def self.load_url(url)
      response = EM::HttpRequest.new(url).get
      #response.callback { EventMachine.stop } if defined? VCR
      if response.response_header.status == 200
        mech = Mechanize.new

        response.response_header["content-type"] = response.response_header["CONTENT_TYPE"]
        page = Mechanize::Page.new(response.req.uri, response.response_header, response.response, 200, mech)
        return page
      end

    end
  end
end