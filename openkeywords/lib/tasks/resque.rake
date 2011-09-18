require 'resque/tasks'

task "resque:setup" => :environment do
  # require all files under lib/jobs
  Dir[File.dirname(__FILE__) + '/../../lib/*.rb'].each { |file| require file }
  # require all files under lib/
end