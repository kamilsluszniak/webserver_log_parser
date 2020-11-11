# frozen_string_literal: true

module WebserverLogParser
  # Class for printing results
  class ResultPrinter
    attr_reader :stats, :unique_views

    def initialize(stats:, unique_views: false)
      @stats = stats
      @unique_views = unique_views
    end

    def call
      mode_title
      stats.each do |stat|
        puts "#{stat[:path]}: #{stat[:count]}"
      end
    end

    private

    def mode_title
      puts "Page #{unique_views ? 'unique ' : ''}views:"
    end
  end
end
