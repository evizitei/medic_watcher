require 'istatus_watcher'

class MedicPoller
  def perform
    watcher = IstatusWatcher.new
    count = watcher.how_many_available?
    centralia_available = watcher.medic_available?("131")
    ashland_available = watcher.medic_available?("241")
    MedicRecord.create!(:count=>count,:m131_available=>centralia_available,:m241_available=>ashland_available)
    Delayed::Job.enqueue(self, 0, 1.minute.from_now)
  end
end