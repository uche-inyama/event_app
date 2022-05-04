class HomeController < ApplicationController
  def index
    require 'net/http'
    require 'json'
    city_name = 'Denver'
    API_key = Rails.application.credentials.openWeather[:api_key]
    @url = "https://api.openweathermap.org/data/2.5/weather?q=#{city_name}&appid=#{API_key}"
    @uri = URI(@url)
    @response = Net::HTTP.get(@uri)
    @output = JSON.parse(@response)
  end
end