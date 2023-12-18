# frozen_string_literal: true

require 'spec_helper'
require_relative '../../../lib/filters/title_length_filter'

ENTRIES_JSON = File.expand_path('../../fixtures/entries_array.rb', __dir__)

RSpec.describe Filters::TitleLengthFilter do
  describe '.call' do
    let(:entries) do
      [
        { title: 'A short title' },
        { title: 'A very long and descriptive title of an article' },
        { title: 'Medium length title' },
        { title: 'Tiny' },
        { title: 'An adequately sized title' }
      ]
    end

    context 'when filtering with operator :>' do
      let(:result) { described_class.call(entries, :>, 5) }

      it 'returns entries with titles longer than the specified length' do
        expect(result.length).to eq(1)
      end
    end

    context 'when filtering with operator :<=' do
      it 'returns entries with titles equal to or shorter than the specified length' do
        result = described_class.call(entries, :<=, 3)
        expect(result.length).to eq(3)
      end
    end

    context 'when filtering with operator :=' do
      it 'returns entries with titles equal to or shorter than the specified length' do
        result = described_class.call(entries, :==, 3)
        expect(result.length).to eq(2)
      end
    end
  end
end
