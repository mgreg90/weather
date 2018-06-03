module Weather
  module TimeAndDate
    class SearchClient

      URL = URI("https://www.timeanddate.com/scripts/completion.php?xd=5&")

      attr_reader :phrase

      def self.search(phrase)
        new(phrase: phrase).search
      end

      def initialize(phrase:)
        @phrase = phrase
      end

      def search
        puts "Finding City...".green.bold
        city
      end

      def city
        @city ||= begin
          line = raw_response.lines.first.split("\t")
          city_args = {
            url_path: line.first,
            name: line[4]
          }
          City.new(city_args)
        end
      end

      def raw_response
        @raw_response ||= begin
          result = HTTParty.get(url)
        end
      end

      def url
        @url ||= begin
          url = URL.dup
          url.query += "query=#{URI.escape(phrase)}"
          url
        end
      end
    end
  end
end