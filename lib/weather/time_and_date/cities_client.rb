module Weather
  module TimeAndDate
    class CitiesClient

      City = Struct.new(:name, :url_path, :index) do
        def display
          puts "#{index}. #{name}"
        end
        
        def to_s
          name
        end
      end

      URL = "https://www.timeanddate.com/weather/"

      def self.choose
        new.choose
      end
      
      def choose
        list_all
        choose_without_list
      end
      
      def choose_without_list
        get_response
        verify_response
        choice
      end
      
      def get_response
        print "Which city do you choose? (Enter a number) : ".yellow.bold
        @response = gets.chomp.strip.to_i
      end
      
      def verify_response
        if choice
          puts "You've chosen #{choice}!".green.bold
        else
          puts "Invalid choice! You must input the number of one of the cities.".red.bold
          choose_without_list
        end
      end
      
      def choice
        @choice ||= cities.find { |city| city.index == @response }
      end

      def list_all
        cities.map(&:display)
      end

      def cities
        @cities ||= fetch_and_parse_cities.sort_by { |city| city.name }
      end
      
      def fetch_and_parse_cities
        cities = parse_cities(fetch_cities).sort_by(&:name)
        cities.each.with_index(1) { |city, index| city.index = index }
      end

      def fetch_cities
        HTTParty.get(URL)
      end
      
      def parse_cities(raw_response)
        page = Nokogiri::HTML(raw_response)
        nodes = page.css("table.zebra a")
        nodes.map { |node| City.new(node.text, node[:href]) }
      end
      
    end
  end
end