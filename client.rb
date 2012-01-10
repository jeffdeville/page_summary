#!/usr/bin/env ruby
require 'rubygems'
require 'eventmachine'

class ClientTest < EM::Connection
  def initialize()
  end

  def post_init
    puts "connected"
    send_data "http://www.thinkgeek.com/tshirts-apparel/unisex/generic/894a/"
    puts "sent url"
  end

  def unbind 
    puts "disconnected"
    close_connection
    EM.stop
  end

  def receive_data(data)
    puts data

  end
end

EM.run do
  EM.connect('localhost', 8080, ClientTest)
end
