class MedicRecord < ActiveRecord::Base
  after_create do |record|
    prior_record = MedicRecord.where("id < #{record.id}").order("id DESC").first
    if !prior_record.nil?
      if((prior_record.count >= 2 and record.count <= 1) or 
         (prior_record.count >= 1 and record.count <= 0) or
         ((prior_record.count <= 1) and record.count >= 2))
         msg = %Q{City Status Is #{record.count}. 
                  M131 -> #{record.m131_status}
                  M241 -> #{record.m241_status}}
         SmsProxy.new.deliver(msg)
      end
    end
    Rails.cache.write('cur_recs',nil)
    Rails.cache.write('cur_msgs',nil) 
  end
  
  def self.main_display
    MedicRecord.limit(10).order("id desc").all
  end
end
