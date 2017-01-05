require_relative '../app'

Mongoid.load!('config/mongoid.yml', ENV['RACK_ENV'])

namespace :wipe do

  desc 'removes tasks'
  task :tasks do
    GeoTM::Task.delete_all
    puts 'Tasks deleted.'
  end

  desc 'removes users'
  task :users do
    GeoTM::User.delete_all
    puts 'Users deleted.'
  end

  desc 'removes all'
  task :all do
    GeoTM::User.delete_all
    GeoTM::Task.delete_all
    puts 'Data wiped out.'
  end
end
