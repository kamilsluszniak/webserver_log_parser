
module WebserverLogParser
  class ParsedLinesAnalyzer
    attr_reader :parsed_lines

    def initialize(parsed_lines:)
      @parsed_lines = parsed_lines
    end

    def call
      count_hits(group_by_path)
    end

    private

    def group_by_path
      raise EmptyParsedLinesException if parsed_lines.empty?
      parsed_lines.group_by {|path, addr| path }
    end

    def count_hits(grouped)
      grouped.map do |path, occurences|
        { path: path, count: occurences.count }
      end
    end
  end
end