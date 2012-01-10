require 'mechanize'

module PageSummary
  class EmMechanize
    extend EmDownloader

    def self.load_url(url)
      load_from_url(url) do |request|
        mech = Mechanize.new
        request.response_header["content-type"] = request.response_header["CONTENT_TYPE"]
        page = Mechanize::Page.new(request.req.uri, request.response_header, request.response, 200, mech)
        return page
      end
    end
  end
end