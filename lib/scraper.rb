# frozen_string_literal: true

require 'httparty'
require 'nokogiri'

# This class is responsible for fetching and parsing the HTML document from Hacker News
class Scraper
  def self.fetch_data(url)
    response = HTTParty.get(url)
    response.body if response.code == 200
  end

  def self.parse_html(html)
    Nokogiri::HTML(html)
  end
end
