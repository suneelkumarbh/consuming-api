require 'httparty'
require 'byebug'
require_relative '../errors/invalid_data'

class GetWeatherInfoService
  BASE_URL = 'https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline'.freeze
  API_KEY = 'ABZL6ZVRBML83QZR28F4B3EU9'.freeze # putting the key in the code is not a good practice, but I am keeping here just to avoid more configuration etc
  COLUMN_WIDTH = 25

  attr_accessor :cities, :start_date, :end_date, :weather_info

  def initialize(cities, start_date, end_date)
    @cities = cities
    @start_date = start_date
    @end_date = end_date
    @weather_info = {}
  end

  def get_weather_data
    raise InvalidData, 'Invalid cities data' unless cities&.all? { |city| city != '' }

    cities.each do |city|
      url = "#{BASE_URL}/#{city.delete(' ')}/#{start_date}/#{end_date}?key=#{API_KEY}"
      response = HTTParty.get(url)

      raise InvalidData, response.body unless response.code == 200

      data = JSON.parse(response.body)

      temps = data['days'].map { |day| day['temp'] }
      winds = data['days'].map { |day| day['windspeed'] }

      temp_avg = temps.sum / temps.length
      temp_median = temps.sort[temps.length / 2]

      wind_avg = winds.sum / winds.length
      wind_median = winds.sort[winds.length / 2]

      @weather_info[city] = { temp_avg: temp_avg, temp_med: temp_median, wind_avg: wind_avg, wind_med: wind_median }
    end
  end

  def display_weather_info
    printf("%-#{COLUMN_WIDTH}s %-#{COLUMN_WIDTH}s %-#{COLUMN_WIDTH}s %-#{COLUMN_WIDTH}s %-#{COLUMN_WIDTH}s\n", 'City',
           'Wind Avg', 'Wind Med', 'Temp Avg', 'Temp Med')
    @weather_info.each do |city, weather|
      printf(
        "%-#{COLUMN_WIDTH}s %-#{COLUMN_WIDTH}.2f %-#{COLUMN_WIDTH}.2f %-#{COLUMN_WIDTH}.2f %-#{COLUMN_WIDTH}.2f\n", city, weather[:wind_avg], weather[:wind_med], weather[:temp_avg], weather[:temp_med]
      )
    end
  end
end
