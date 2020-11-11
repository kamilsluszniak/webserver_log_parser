# frozen_string_literal: true

module WebserverLogParser
  # Class that connects functionalities and decides which analyzer to use
  class Processor
    attr_reader :file_path, :unique_views

    def initialize(file_path:, unique_views: false)
      @file_path = file_path
      @unique_views = unique_views
    end

    def call
      file = FileReader.new(file_path: file_path).call
      parsed_lines = LogLinesParser.new(file: file).call
      analyzer_class.new(parsed_lines: parsed_lines).call
    end

    private

    def analyzer_class
      unique_views ? UniqueParsedLinesAnalyzer : ParsedLinesAnalyzer
    end
  end
end
