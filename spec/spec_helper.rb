ENV['RACK_ENV'] = 'test'

require 'minitest/spec'
require 'minitest/autorun'
require 'rack/test'
require 'database_cleaner'
require_relative 'helpers/location'

require File.expand_path '../../lib/geo_tm/app.rb', __FILE__

Mongoid.load!('config/mongoid.yml', ENV['RACK_ENV'])

DatabaseCleaner.strategy = :truncation

class Minitest::Spec
  before :each do
    DatabaseCleaner.start
  end

  after :each do
    DatabaseCleaner.clean
  end
end
