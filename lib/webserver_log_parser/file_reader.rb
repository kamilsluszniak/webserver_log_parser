# frozen_string_literal: true

module WebserverLogParser
  # File reader and validator class
  class FileReader
    VALID_FORMATS = %w[.txt .log].freeze
    attr_reader :file_path

    def initialize(file_path:)
      @file_path = file_path
    end

    def call
      check_file
      read_file
    end

    private

    def read_file
      File.open(file_path, 'r')
    end

    def check_file
      raise FileNotFoundException unless File.file?(file_path)
      raise FileEmptyException if File.zero?(file_path)

      validate_format
    end

    def validate_format
      raise UnacceptedFileFormatException unless VALID_FORMATS.include? File.extname(file_path)
    end
  end
end
