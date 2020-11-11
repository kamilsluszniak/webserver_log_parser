# frozen_string_literal: true

module WebserverLogParser
  # Main class for parsing log files and presenting stats
  class WebagesVisitsStats
    attr_reader :file_path, :unique_views

    def initialize(file_path:, unique_views: false)
      @file_path = file_path
      @unique_views = unique_views
    end

    def call
      stats = Processor.new(file_path: file_path, unique_views: unique_views).call
      sorted = sort_stats_descending(stats)
      ResultPrinter.new(stats: sorted, unique_views: unique_views)
    end

    private

    def sort_stats_descending(stats)
      stats.sort_by { |hash| hash[:count] }.reverse!
    end
  end
end
