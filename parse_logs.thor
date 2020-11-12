# frozen_string_literal: true

require 'webserver_log_parser'

class WebagesVisitsStats < Thor
  desc "parse_logs", "webserver parsing logs task"
  method_option :unique, :aliases => "-u --unique", type: :boolean, desc: "unique addresses flag"
  def parse_logs(file_path)
    WebserverLogParser::WebagesVisitsStats.new(file_path: file_path, unique_views: options[:unique]).call
  end

end