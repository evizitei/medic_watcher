class MainController < ApplicationController
  
  def home
    Time.zone = "America/Chicago"
    #prime_cache
    @records = MedicRecord.main_display #Rails.cache.read('cur_recs')
    @messages = MedicAlert.main_display #Rails.cache.read('cur_msgs')
  end
  
  def graphs
    total = MedicRecord.count.to_f
    two_plus = MedicRecord.status_norm.size.to_f/total
    one = MedicRecord.status_one.size.to_f/total
    zero = MedicRecord.status_zero.size.to_f/total
    @data_string = "[['Two or more',#{two_plus}],['One',#{one}],['Zero',#{zero}]]"
  end
  
  def test_message
    SmsProxy.new.deliver("TEST ONLY message from medic watcher")
    flash[:notice] = "Message sent"
    redirect_to :action=>:home
  end
  
protected
  # def prime_cache
  #     if Rails.cache.read('cur_recs').nil?
  #       Rails.cache.write('cur_recs',MedicRecord.main_display) 
  #     end
  #     if Rails.cache.read('cur_msgs').nil?
  #       Rails.cache.write('cur_msgs',MedicAlert.main_display) 
  #     end
  #   end
end
