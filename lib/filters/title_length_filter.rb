# frozen_string_literal: true

module Filters
  # Usage example:
  # Filters::TitleLengthFilter.call(entries, :>, 5) # selects entries with titles longer than 5 words
  # Filters::TitleLengthFilter.call(entries, :<=, 5) # selects entries with titles 5 words or shorter
  #
  # This filter allows to select entries with {dynamic operator (:>, :<, :<=)} {dynamic length}
  class TitleLengthFilter
    class << self
      def call(entries, operator, length)
        entries.select do |entry|
          entry[:title].split.length.send(operator, length)
        end
      end
    end
  end
end
