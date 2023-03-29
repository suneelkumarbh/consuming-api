require_relative 'services/get_weather_info_service'
require 'date'

cities = [
  'Copenhagen, Denmark',
  'Lodz, Poland',
  'Brussels, Belgium',
  'Islamabad, Pakistan'
]

# On the free account, I am able to retrieve the weather records for a single city only once
# cities = [
#   'Islamabad, Pakistan'
# ]

start_date = (Date.today - 30).strftime('%Y-%m-%d')
end_date = Date.today.strftime('%Y-%m-%d')

cities_weather_info = GetWeatherInfoService.new(cities, start_date, end_date)
cities_weather_info.set_weather_info
cities_weather_info.display_weather_info
