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
      search_phrase = ask_for_city
      city = TimeAndDate::SearchClient.search(search_phrase)
      TimeAndDate::CityWeatherClient.display_weather_for(city)
    rescue SystemExit, Interrupt
      puts
      puts ("=-" * (`tput cols`.strip.to_i / 2)).red.bold
      puts "Manually cancelled.".red.bold
      puts "Alright then. Goodbye!".yellow.bold
      exit
    end
    
    def ask_for_city
      puts "What city's weather would you like to know?".yellow.bold
      print "City: ".yellow.bold
      gets.chomp
    end

  end
end