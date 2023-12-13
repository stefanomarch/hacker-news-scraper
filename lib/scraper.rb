# frozen_string_literal: true

require 'httparty'
require 'nokogiri'

# This class is responsible for fetching and parsing the HTML document
# from Hacker News
class Scraper
  HACKER_NEWS_URL = 'https://news.ycombinator.com/'

  def self.fetch_data
    response = HTTParty.get(HACKER_NEWS_URL)
    response.body if response.code == 200
  end

  def self.parse_html(html)
    Nokogiri::HTML(html)
  end
end
