module Weather
  class Cli
    def self.start
      greet
      instance = new
      instance.start
      instance
    end

    def self.greet
      puts "So you want the weather, bozo??".green.bold
    end

    def start
      city = TimeAndDate::CitiesClient.choose
      TimeAndDate::CityWeatherClient.display_weather_for(city)
    end

  end
end