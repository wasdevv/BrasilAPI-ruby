# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!

# caso o CEP esteja INVALIDA.
Rails.logger.level = Logger::WARN