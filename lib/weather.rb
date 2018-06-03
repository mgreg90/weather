require "httparty"
require "nokogiri"
require "colorize"

require_relative "weather/cli"
require_relative "weather/time_and_date"
require_relative "weather/version"

module Weather
  def self.start
    Cli.start
  end
end
