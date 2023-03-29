require 'httparty'
require 'byebug'

class GetWeatherInfoService
  attr_accessor :cities, :start_date, :end_date, :weather_info

  def initialize(cities, start_date, end_date)
    @cities = cities
    @start_date = start_date
    @end_date = end_date
    @weather_info = {}
  end

  def get_weather_data
    cities.each do |city|
      # putting the key in the code is not a good practice, but I am keeping here just to avoid more configuration etc
      response = HTTParty.get("https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/#{city.delete(' ')}/#{start_date}/#{end_date}?key=MWC4LLU3US34D3H6RC6B5WA65")
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
    @weather_info.each do |key, value|
      puts "#{key}   #{value[:wind_avg].round(2)}  #{value[:wind_med].round(2)}  #{value[:temp_avg].round(2)}  #{value[:temp_med].round(2)}"
    end
  end
end
