# frozen_string_literal: true

require 'webserver_log_parser/version'
Dir[File.join(__dir__, 'webserver_log_parser', 'exceptions', '*.rb')].sort.each { |file| require file }
require 'webserver_log_parser/file_reader'
require 'webserver_log_parser/log_lines_parser'
require 'webserver_log_parser/processor'
require 'webserver_log_parser/result_printer'
require 'webserver_log_parser/webpages_visits_stats'
Dir[File.join(__dir__, 'webserver_log_parser', 'parsed_lines_analyzer', '*.rb')].sort.each { |file| require file }

# Base module
module WebserverLogParser
end
