# frozen_string_literal: true
require 'pry'
require 'simplecov'

SimpleCov.start

PROJECT_ROOT = File.expand_path('..', __dir__)
Dir[File.join(PROJECT_ROOT, 'lib/**', '*.rb')].each { |f| require f }
