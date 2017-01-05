require 'rake/testtask'

Rake::TestTask.new do |t|
  t.pattern = 'spec/**/*_spec.rb'
end

Dir.glob('lib/geo_tm/tasks/*.rake').each { |task| load task }

task default: :test
