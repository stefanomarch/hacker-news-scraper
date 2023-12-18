# frozen_string_literal: true

require 'spec_helper'
require_relative '../../lib/hacker_news_scraper'

HACKER_NEWS_FIXTURE_PATH = File.expand_path('../fixtures/hacker_rank_source.html', __dir__)

RSpec.describe HackerNewsScraper do
  describe '#scrape' do
    let(:html_fixture) { File.read(HACKER_NEWS_FIXTURE_PATH) }

    before do
      allow(Scraper).to receive(:fetch_data).and_return(html_fixture)
      allow(Scraper).to receive(:parse_html).with(html_fixture).and_call_original
    end

    it 'fills entries with up to 30 items' do
      scraper = described_class.new
      scraper.scrape
      expect(scraper.entries.size).to be <= 30
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
  end
end
