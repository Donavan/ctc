require 'rubygems'
require 'bundler/setup'
require 'pry'
require 'oga'
require 'json'
require_relative 'fox_now/show_page'

class FoxNow
  @url = 'http://www.fox.com/full-episodes?sort_by=title'.freeze
  @cache_file = '.foxnow'.freeze
  class << self
    attr_accessor :url, :cache_file
  end

  attr_accessor :doc

  def initialize(document)
    @doc= document
  end

  def parse(queue)
    page = ShowPage.new(doc)

    page.each_show do |show|
      queue.publish show.to_h.to_json
    end
  end
end