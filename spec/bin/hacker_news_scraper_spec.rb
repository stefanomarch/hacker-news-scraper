# frozen_string_literal: true

require 'spec_helper'
require 'byebug'
require 'open3'

describe 'HackerNewsScraper' do
  let(:script_path) { 'bin/hacker_news_scraper' }

  describe 'User Interaction' do
    context 'when scraping without filters' do
      let(:input) { "1\n3\n" }
      let(:output) { Open3.capture2e("ruby #{script_path}", stdin_data: input).first }

      it 'executes successfully' do
        expect(Open3.capture2e("ruby #{script_path}", stdin_data: input).last.success?).to be true
      end

      it 'includes the scraper header in the output' do
        expect(output).to include('HackerNews Scraper')
      end
    end

    context 'when applying filter option 1' do
      let(:input) { "2\n1\n3\n" }
      let(:output) { Open3.capture2e("ruby #{script_path}", stdin_data: input).first }

      it 'executes successfully' do
        expect(Open3.capture2e("ruby #{script_path}", stdin_data: input).last.success?).to be true
      end

      it 'includes the filter text for option 1 in the output' do
        expect(output).to include('Filter entries with less than or equal to five words')
      end
    end

    context 'when applying filter option 2' do
      let(:input) { "2\n2\n3\n" }
      let(:output) { Open3.capture2e("ruby #{script_path}", stdin_data: input).first }

      it 'executes successfully' do
        expect(Open3.capture2e("ruby #{script_path}", stdin_data: input).last.success?).to be true
      end

      it 'includes the filter text for option 2 in the output' do
        expect(output).to include('Filter entries with more than five words')
      end
    end

    context 'when choosing to exit' do
      let(:input) { "3\n" }
      let(:output) { Open3.capture2e("ruby #{script_path}", stdin_data: input).first }

      it 'executes successfully' do
        expect(Open3.capture2e("ruby #{script_path}", stdin_data: input).last.success?).to be true
      end

      it 'includes the exit message in the output' do
        expect(output).to include('Exiting...')
      end
    end

    context 'when choosing an invalid option' do
      let(:input) { "8\n" }
      let(:output) { Open3.capture2e("ruby #{script_path}", stdin_data: input).first }

      it 'fails to execute successfully' do
        expect(Open3.capture2e("ruby #{script_path}", stdin_data: input).last.success?).to be false
      end

      it 'includes the invalid option message in the output' do
        expect(output).to include('Invalid option. Please try again.')
      end
    end
  end
end
