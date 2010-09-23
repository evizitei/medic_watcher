require 'istatus_watcher'

class MedicPoller
  def perform
    watcher = IstatusWatcher.new
    count = watcher.how_many_available?
    centralia_status = watcher.medic_status?("131")
    ashland_status = watcher.medic_status?("241")
    MedicRecord.create!(:count=>count,:m131_status=>centralia_status,:m241_status=>ashland_status)
    Delayed::Job.enqueue(self, 0, 1.minute.from_now)
  end
end