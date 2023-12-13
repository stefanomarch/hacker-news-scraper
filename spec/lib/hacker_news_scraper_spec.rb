# frozen_string_literal: true

require 'spec_helper'
require_relative '../../lib/hacker_news_scraper'

RSpec.describe HackerNewsScraper do
  describe '#initialize' do
    it 'is a HackerNewsScraper' do
      expect(HackerNewsScraper.new).to be_a(HackerNewsScraper)
    end
  end
end
