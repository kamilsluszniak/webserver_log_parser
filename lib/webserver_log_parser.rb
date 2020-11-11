require "webserver_log_parser/version"
Dir[File.join(__dir__, 'webserver_log_parser', 'exceptions', '*.rb')]
  .each { |file| require file }
require "webserver_log_parser/file_reader"

module WebserverLogParser
end
