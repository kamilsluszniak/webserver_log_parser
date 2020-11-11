# frozen_string_literal: true

module WebserverLogParser
  # Child class of lines analyzer that presents unique hit results
  class UniqueParsedLinesAnalyzer < ParsedLinesAnalyzer
    private

    def count_hits(grouped)
      grouped.map do |path, occurences|
        { path: path, count: occurences.uniq.count }
      end
    end
  end
end
