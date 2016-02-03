#!/usr/bin/env ruby
require 'rubygems'
require 'bundler/setup'
require 'pry'
require 'httparty'
require 'oga'
require 'bunny'
require_relative 'models'
require_relative 'fox_now'

def content(source)
  if File.exist?(source.cache_file)
    File.read(source.cache_file)
  else
    response = HTTParty.get(source.url)
    File.open(source.cache_file, 'w') { |f| f.write(response.body) }
    response.body
  end
end

document = Oga.parse_html content(FoxNow)

parser = FoxNow.new(document)



# Start a communication session with RabbitMQ
conn = Bunny.new(host: 'rabbit')
conn.start

ch   = conn.create_channel
q    = ch.fanout('episodes.incoming')
ch.queue("joe",   :auto_delete => true).bind(q).subscribe do |delivery_info, metadata, payload|
  puts "#{payload} => joe"
end
parser.parse q

#sleep 60

