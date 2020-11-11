# frozen_string_literal: true

module WebserverLogParser
  # Log file parser
  class LogLinesParser
    attr_reader :file, :parsed_lines

    def initialize(file:)
      @file = file
      @parsed_lines = []
    end

    def call
      read_lines
      parsed_lines
    end

    private

    def read_lines
      file.each_line do |line|
        url, address = line.split
        @parsed_lines << [url, address]
      end
    end
  end
end
