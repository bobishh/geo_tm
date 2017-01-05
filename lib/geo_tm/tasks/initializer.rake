require_relative '../app'
require_relative '../../../spec/helpers/location'

task :initialize_demo do
  puts 'Creating users...'
  42.times do |i|
    GeoTM::User.create token: SecureRandom.hex,
                       role: 'manager',
                       name: "Squidward_#{i}"

    GeoTM::User.create token: SecureRandom.hex,
                       role: 'driver',
                       name: "Patrick_#{i}"
  end
  puts 'Creating tasks...'

  manager = GeoTM::User.where(role: 'manager').first
  GeoTM::Task.create_indexes

  4242.times do
    GeoTM::Task::Create.(token: manager.token,
                         task: GeoTM::SpecHelpers.random_locations)
  end
  puts 'Demo data initialized.'
end
