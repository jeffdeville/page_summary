require 'em-websocket'
require 'em-synchrony'
require 'em-synchrony/em-http'
require 'json'

module PageSummary
  class Server
    def self.run

      EM.synchrony do
        p "Server started at #{Config::HOST}:#{Config::PORT}"
        EM::WebSocket.start(:host => Config::HOST, :port => Config::PORT) do |web_socket|
          web_socket.onopen do
            p 'connected'
          end
          web_socket.onmessage do |msg|
            Fiber.new do
              p "I got a message: #{msg}"
              begin
                summarizer = Summarizer.new(msg)
                p "Summarizer newed up with title: #{summarizer.title}"
                web_socket.send({type: "title", title: summarizer.title}.to_json)
                summarizer.potential_images do |image|
                  p "got a result: #{image}"
                  web_socket.send image.merge({type: "image"}).to_json
                end
              rescue
                p $!
              end
            end.resume
          end

          web_socket.onclose { puts 'closed' }
          web_socket.onerror { |e| puts "err #{e.message}" }
        end
      end
    end
  end
end