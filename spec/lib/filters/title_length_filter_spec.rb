# frozen_string_literal: true

require 'spec_helper'
require_relative '../../../lib/filters/title_length_filter'
require 'byebug'

ENTRIES_JSON = File.expand_path('../../fixtures/entries_array.rb', __dir__)

RSpec.describe Filters::TitleLengthFilter do
  describe '.call' do
    let(:entries) do
      [
        { title: 'A short title', points: 10, n_of_comments: 10 },
        { title: 'A very long and descriptive title of an article', points: 11, n_of_comments: 0 },
        { title: 'Medium length title', points: 7, n_of_comments: 20 },
        { title: 'Tiny', points: 1, n_of_comments: 5 },
        { rank: 5, title: 'An adequately sized title', points: 5, n_of_comments: 70 }
      ]
    end

    context 'when filtering with operator :>' do
      let(:result) { described_class.call(entries, :>, 5).entries }

      it 'returns entries with titles longer than the specified length' do
        expect(result.length).to eq(1)
      end
    end

    context 'when filtering with operator :<=' do
      it 'returns entries with titles equal to or shorter than the specified length' do
        result = described_class.call(entries, :<=, 3).entries
        expect(result.length).to eq(3)
      end
    end

    context 'when filtering with operator :=' do
      it 'returns entries with titles equal to or shorter than the specified length' do
        result = described_class.call(entries, :==, 3).entries
        expect(result.length).to eq(2)
      end
    end
  end
end
