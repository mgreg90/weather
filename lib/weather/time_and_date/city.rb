module Weather
  module TimeAndDate
    class City
      attr_reader :url_path, :name
      
      def initialize(name:, url_path:)
        @name = name
        @url_path = url_path
      end
    end
  end
end