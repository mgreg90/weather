module Weather
  module TimeAndDate
    class CityWeatherClient
      
      attr_reader :city
      
      URL = "http://timeanddate.com"
      
      def self.display_weather_for(city)
        new(city).display_weather
      end
      
      def display_weather
        nokogiri
        system("clear") || system("cls")
        puts ("-=" * (`tput cols`.to_i / 2)).green.bold
        puts "#{city.name}".light_green.bold
        puts "Fahrenheit Temperature: #{fahrenheit_temperature}".green.bold
        puts "Weather: #{description}".green.bold
        puts "#{forecast}".green.bold
        puts "Current Time: #{current_time}".green.bold
        puts "Last Report: #{last_report}".green.bold
        puts ("-=" * (`tput cols`.to_i / 2)).green.bold
      end
      
      def initialize(city)
        @city = city
      end
      
      def url
        "#{URL}#{city.url_path}"
      end
      
      def raw_response
        @raw_response ||= begin
          puts "Fetching data...".green.bold
          HTTParty.get(url)
        end
      end
      
      def nokogiri
        @nokogiri ||= Nokogiri::HTML(raw_response)
      end
      
      def fahrenheit_temperature
        nokogiri.css("#qlook div.h2").text
      end
      
      def description
        nokogiri.css("#qlook p").first.text.reverse.sub('.', '').reverse
      end
      
      def feels_like
        nokogiri.css("#qlook p")[1].children.first.text
      end
      
      def forecast
        nokogiri.css("#qlook p")[1].children[2].text
      end
      
      def wind
        speed = nokogiri.css("#qlook p")[1].children[4].text
        direction = nokogiri.css("#qlook p")[1].children[5].children.text
        "#{speed}#{direction}"
      end
      
      def current_time
        nokogiri.css("#wtct").text.strip
      end

      def last_report
        nokogiri.css("#qfacts").children[2].children[1].text.strip
      end
      
    end
  end
end