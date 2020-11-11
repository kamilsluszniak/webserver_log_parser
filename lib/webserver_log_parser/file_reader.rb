module WebserverLogParser
  class FileReader
    attr_reader :file_path

    def initialize(file_path:)
      @file_path = file_path
    end

    def call
      read_file
    end

    private

    def read_file
      File.open(file_path, "r")
    rescue Errno::ENOENT
      raise FileNotFoundException
    end
  end
end