class GetWeatherInfoService
  attr_accessor :cities, :start_date, :end_date

  def initialize(cities, start_date, end_date)
    @cities = cities
    @start_date = start_date
    @end_date = end_date
  end
end
