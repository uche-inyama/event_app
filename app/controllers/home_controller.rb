class HomeController < ApplicationController
  def index
    require 'net/http'
    require 'json'

    url = 'http://jsonplaceholder.typecode.com/posts/1'
    uri = URI(url)
    response = Net::HTTP.get(uri)
    standard = JSON.parse(response)
    @post = JSON.parse(response, symbolize_name: true)
  end
end