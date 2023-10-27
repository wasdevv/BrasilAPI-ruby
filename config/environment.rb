# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!

# caso o CEP esteja INVALIDA.
Rails.logger = Logger.new("log/#{Rails.env}.log")
Rails.logger.level = Logger::WARN

Rails.logger.formatter = proc do |severity, datetime, progname, msg|
    "#{datetime}|#{severity}|#{progname}|#{msg}\n"
end