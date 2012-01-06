require 'em-websocket'
require 'em-synchrony'
require 'json'

#EM.synchrony do
#  put "Server started at 0.0.0.0:8080"
#  #EM::WebSocket.start(:host => '0.0.0.0', :port => 8080) do |web_socket|
#  #  web_socket.onmessage do |msg|
#  #    Fiber.new do
#  #      summarizer = Summarizer.new(msg)
#  #      web_socket.send({type: "title", title: summarizer.title})
#  #      summarizer.potential_images do |image|
#  #        web_socket.send image.merge({type: "image"})
#  #      end
#  #    end.resume
#  #  end
#  #end
#end