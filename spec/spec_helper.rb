# frozen_string_literal: true

PROJECT_ROOT = File.expand_path('..', __dir__)

Dir[File.join(PROJECT_ROOT, 'lib/**', '*.rb')].each { |f| require f }
require 'pry'

RSpec.configure do |config|
end
