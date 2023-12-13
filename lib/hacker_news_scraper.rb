# frozen_string_literal: true

require_relative 'scraper'
require 'byebug'

# This class is the orchestrator of methods that will scrape Hacker
# News, including filtering and sorting
class HackerNewsScraper
  attr_reader :entries

  def initialize
    @entries = []
  end

  # rubocop:disable Metrics/AbcSize
  def scrape
    html = Scraper.fetch_data
    parsed_html = Scraper.parse_html(html)

    parsed_html.css('tr.athing').each_with_index do |indexed_row, index|
      break if index == 30

      rank = indexed_row.css('span.rank').text.gsub('.', '').to_i
      title = indexed_row.css('span.titleline > a').text

      subtext = indexed_row.next_element
      points = subtext.css('span.score').text.to_i
      comments = subtext.css('a').last.text.to_i

      entries << entry_hash(comments, points, rank, title)
    end
  end
  # rubocop:enable Metrics/AbcSize

  private

  def entry_hash(comments, points, rank, title)
    {
      rank: rank,
      title: title,
      points: points,
      n_of_comments: comments
    }
  end
end
