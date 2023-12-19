# frozen_string_literal: true

module Filters
  # Usage example:
  # Filters::TitleLengthFilter.call(entries, :>, 5) # selects entries with titles longer than 5 words
  #
  # This filter allows to select entries with {dynamic operator (:>, :<, :<=)} {dynamic length}
  class TitleLengthFilter
    attr_reader :entries

    # Initializes with the filtered entries
    def initialize(entries)
      @entries = entries
    end

    def self.call(entries, operator, length)
      entries.select do |entry|
        entry[:title].split.length.send(operator, length)
      end
    end
  end
end
