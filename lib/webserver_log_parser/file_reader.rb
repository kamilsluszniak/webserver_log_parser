module WebserverLogParser
  class FileReader
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
    end
  end
end