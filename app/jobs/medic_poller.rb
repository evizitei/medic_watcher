require 'istatus_watcher'

class MedicPoller
  def perform
    count = IstatusWatcher.new.how_many_available?
    MedicRecord.create!(:count=>count)
    Delayed::Job.enqueue(self, 0, 1.minute.from_now)
  end
end