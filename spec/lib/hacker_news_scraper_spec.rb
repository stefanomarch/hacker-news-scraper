# frozen_string_literal: true

require 'spec_helper'
require_relative '../../lib/hacker_news_scraper'

HACKER_NEWS_FIXTURE_PATH = File.expand_path('../fixtures/hacker_rank_source.html', __dir__)

RSpec.describe HackerNewsScraper do
  describe '#scrape' do
    let(:html_fixture) { File.read(HACKER_NEWS_FIXTURE_PATH) }
    let(:hacker_news_scraper) { described_class.new }

    before do
      allow(GeneralScraper).to receive(:fetch_data).and_return(html_fixture)
      allow(GeneralScraper).to receive(:parse_html).with(html_fixture).and_call_original
      hacker_news_scraper.scrape
    end

    it 'fills entries with up to 30 items' do
      expect(hacker_news_scraper.entries.size).to be <= 30
    end

    context 'when examining the first entry' do
      let(:first_entry) { described_class.new.tap(&:scrape).entries.first }

      it 'extracts rank as an Integer' do
        expect(first_entry[:rank]).to be_a(Integer)
      end

      it 'extracts title as a String' do
        expect(first_entry[:title]).to be_a(String)
      end

      it 'extracts points as an Integer' do
        expect(first_entry[:points]).to be_a(Integer)
      end

      it 'extracts number of comments as an Integer' do
        expect(first_entry[:n_of_comments]).to be_a(Integer)
      end
    end

    describe 'filtered entries by title ordered by number of comments' do
      it 'eventually fills the filtered_entries_by_title_ordered_by_n_of_comments' do
        sleep 1
        expect(hacker_news_scraper.filtered_entries_by_title_ordered_by_n_of_comments).not_to be_nil
      end

      it 'ensures the filtered_entries_by_title_ordered_by_n_of_comments is not empty' do
        sleep 1
        expect(hacker_news_scraper.filtered_entries_by_title_ordered_by_n_of_comments).not_to be_empty
      end

      it 'orders entries correctly by number of comments' do
        sleep 1
        entries_ordered_by_comments = hacker_news_scraper.filtered_entries_by_title_ordered_by_n_of_comments
        expect(entries_ordered_by_comments.each_cons(2).all? do |a, b|
                 a[:n_of_comments] >= b[:n_of_comments]
               end).to be true
      end
    end

    describe 'filtered entries by title ordered by points' do
      it 'eventually fills the filtered_entries_by_title_ordered_by_points' do
        sleep 1
        expect(hacker_news_scraper.filtered_entries_by_title_ordered_by_points).not_to be_nil
      end

      it 'ensures the filtered_entries_by_title_ordered_by_points is not empty' do
        sleep 1
        expect(hacker_news_scraper.filtered_entries_by_title_ordered_by_points).not_to be_empty
      end

      it 'orders entries correctly by points' do
        sleep 1
        entries_ordered_by_points = hacker_news_scraper.filtered_entries_by_title_ordered_by_points
        expect(entries_ordered_by_points.each_cons(2).all? { |a, b| a[:points] >= b[:points] }).to be true
      end
    end
  end
end
