# consuming-api

## Approach

In this program, I've used the service object design pattern to retrieve and display weather information using the `get_weather_info_service` service. I've also implemented custom error handling to make the program more robust.

## How to run this program

Before running the program, ensure that all the required gems are installed by running `bundle install`. The entry point for the application is the `application.rb` file. To run the program, execute `ruby application.rb` in your terminal.

## More information

Please note that the API key used in this program may not work due to limitations on the number of requests that can be made with a free account. If you encounter issues, try changing the API key by modifying the code in get_weather_info_service.rb file on line 6 https://github.com/suneelkumarbh/consuming-api/blob/master/services/get_weather_info_service.rb#L6.
