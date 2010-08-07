require 'istatus_watcher'

task :how_many_medics => :environment do
  puts IstatusWatcher.new.how_many_available?
end