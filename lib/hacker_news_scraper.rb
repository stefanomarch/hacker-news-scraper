# frozen_string_literal: true

require_relative 'general_scraper'
require_relative 'filters/title_length_filter'

# This class is the orchestrator of methods that will scrape Hacker News
class HackerNewsScraper
  HACKER_NEWS_URL = 'https://news.ycombinator.com/'
  attr_reader :entries,
              :filtered_entries_by_title_ordered_by_n_of_comments,
              :filtered_entries_by_title_ordered_by_points

  def initialize
    @entries = []
    @filtered_entries_by_title_ordered_by_n_of_comments = nil
    @filtered_entries_by_title_ordered_by_points = nil
  end

  # rubocop:disable Metrics/AbcSize
  def scrape
    html = GeneralScraper.fetch_data(HACKER_NEWS_URL)
    parsed_html = GeneralScraper.parse_html(html)

    parsed_html.css('tr.athing').each_with_index do |indexed_row, index|
      break if index == 30

      rank = indexed_row.css('span.rank').text.gsub('.', '').to_i
      title = indexed_row.css('span.titleline > a').text
      subtext = indexed_row.next_element
      points = subtext.css('span.score').text.to_i
      n_of_comments = subtext.css('a').last.text.to_i

      entries << entry_hash(n_of_comments, points, rank, title)
    end

    start_background_filtering
  end
  # rubocop:enable Metrics/AbcSize

  private

  def entry_hash(n_of_comments, points, rank, title)
    { rank:, title:, points:, n_of_comments: }
  end

  def start_background_filtering
    Thread.new do
      @filtered_entries_by_title_ordered_by_n_of_comments =
        Filters::TitleLengthFilter.call(entries, :>, 5)
                                  .sort_by { |entry| entry[:n_of_comments] }.reverse
    end

    Thread.new do
      @filtered_entries_by_title_ordered_by_points =
        Filters::TitleLengthFilter.call(entries, :<=, 5)
                                  .sort_by { |entry| entry[:points] }.reverse
    end
  end
end
