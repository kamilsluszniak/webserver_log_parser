module WebserverLogParser
  class UniqueParsedLinesAnalyzer < ParsedLinesAnalyzer
    private

    def count_hits(grouped)
      grouped.map do |path, occurences|
        { path: path, count: occurences.uniq.count }
      end
    end
  end
end