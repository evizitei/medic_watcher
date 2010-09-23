class MedicRecord < ActiveRecord::Base
  scope :status_zero, where(:count=>0)
  scope :status_one, where(:count=>1)
  scope :status_norm, where("count >= 2")
  
  after_create do |record|
    prior_record = MedicRecord.where("id < #{record.id}").order("id DESC").first
    if !prior_record.nil?
      if((prior_record.count >= 2 and record.count <= 1) or 
         (prior_record.count >= 1 and record.count <= 0) or
         ((prior_record.count <= 1) and record.count >= 2))
         SmsProxy.new.deliver("City Status Is #{record.count}")
      end
    end
  end
end
