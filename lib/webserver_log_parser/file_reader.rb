module WebserverLogParser
  class FileReader
    VALID_FORMATS = %w(.txt .log)
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
      File.open(file_path, "r")
    end

    def check_file
      if !File.file?(file_path)
        raise FileNotFoundException
      elsif File.zero?(file_path)
        raise FileEmptyException
      end
      validate_format
    end

    def validate_format
      unless VALID_FORMATS.include? File.extname(file_path)
        raise UnacceptedFileFormatException
      end
    end
  end
end