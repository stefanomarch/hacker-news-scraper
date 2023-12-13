# frozen_string_literal: true

require 'spec_helper'
require_relative '../../lib/scraper'

HACKER_NEWS_FIXTURE_PATH = File.expand_path('../fixtures/hacker_rank_source.html', __dir__)

describe Scraper do
  let(:html_content) { File.read(HACKER_NEWS_FIXTURE_PATH) }
  let(:parsed_document) { Scraper.parse_html(html_content) }

  describe '.fetch_data' do
    it 'fetches HTML content that is not empty' do
      expect(html_content).not_to be_empty
    end

    it 'fetches HTML content that includes <html> tag' do
      expect(html_content).to include('<html')
    end
  end

  describe '.parse_html' do
    it 'returns a Nokogiri::HTML::Document' do
      expect(parsed_document).to be_a(Nokogiri::HTML::Document)
    end

    it 'contains a body tag in the parsed document' do
      expect(parsed_document.css('body')).not_to be_empty
    end
  end
end
