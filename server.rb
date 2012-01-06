require 'em-websocket'
require 'em-synchrony'
require 'em-synchrony/em-http'
require 'mechanize'

require 'json'
require "mini_magick"


class GetSummary
  attr_reader :url
  
  def load_page(url)
    @url = url 
    req = EM::HttpRequest.new(url).get()
    if req.response_header.status != 200
      {error: req}
    else
      req
    end
  end

  def map_to_mechanize(page_response)
    page_response.response_header["content-type"] = page_response.response_header["CONTENT_TYPE"]
    mech = Mechanize.new
    page = Mechanize::Page.new(page_response.req.uri, page_response.response_header, page_response.response, 200, mech)
    page
  end

  def find_potential_images(page)

   images = page.images.collect do |img|
     img.url
   end.find_all { |img| not_throw_away_image?(img) }.uniq
  end

  def not_throw_away_image?(img_url)
    !img_url.nil? || !/sprite/i.match(img_url) || !/pixel/i.match(img_url)
  end

  def product_image(image_url)
    file = EM::HttpRequest.new(image_url).get 
    img = ::MiniMagick::Image.read file.response 
    width = img[:width]
    height = img[:height]
    ratio = width.to_f / height.to_f
    false unless 0.5625 <= ratio and ratio <= 1.77 # 16:9
    if width * height > 15000
      {:url => image_url, :width => width, :height => height}
    end
  end
end

EM.synchrony do
  puts "Server started on 0.0.0.0:8080 (drag index.html to your browser)"
  EM::WebSocket.start(:host => '0.0.0.0', :port => 8080) do |websocket|
    websocket.onopen { puts "client connected" }

    websocket.onmessage do |msg|
      puts "received msg: #{msg}"
      Fiber.new do
        get_summary = GetSummary.new()
        # load the msg's url. don't parse the html yet, I don't think
        #

        # pageSummary = PageSummary.new(url)
        # page_content = pageSummary.parse(url)
        # websocket.send({title: page_content.title, summary: page_content.summary})
        # page_summary.potential_images.each do |img|
        #   websocket.send({url: img.url, width: width, height: height})
        # end
        page_response = get_summary.load_page(msg)
        if page_response
          page = get_summary.map_to_mechanize(page_response)
          websocket.send({:type => 'title', :title => page}.to_json)
          potential_images = get_summary.find_potential_images(page)
          potential_images.each do |img|
            result = get_summary.product_image img
            if result
              websocket.send({:type => 'image'}.merge(result).to_json)
            end
          end
        else
          websocket.send({:type => 'error', :message => 'Unable to load the html'}.to_json)
        end
      end.resume

    end

    websocket.onclose { puts 'closed' }
    websocket.onerror {|e| puts "err #{e.message}"}
  end
end
