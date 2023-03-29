require 'httparty'

class GetWeatherInfoService
  attr_accessor :cities, :start_date, :end_date

  def initialize(cities, start_date, end_date)
    @cities = cities
    @start_date = start_date
    @end_date = end_date
  end

  def get_weather_data
    cities.each do |city|
      # putting the key in the code is not a good practice, but I am keeping here just to avoid more configuration etc
      response = HTTParty.get("https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/#{city.delete(' ')}/#{start_date}/#{end_date}?key=D3HWS98QCH2VQMNDPSWN6X5S8")
      data = JSON.parse(response)

      temps = data['days'].map { |day| day['temp'] }
      winds = data['days'].map { |day| day['windspeed'] }

      temp_avg = temps.sum / temps.length
      temp_median = temps.sort[temps.length / 2]

      wind_avg = winds.sum / winds.length
      wind_median = winds.sort[winds.length / 2]
    end
  end
end
