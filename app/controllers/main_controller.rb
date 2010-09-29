require 'istatus_watcher'
class MainController < ApplicationController
  
  def home
    Time.zone = "America/Chicago"
    #prime_cache
    @records = MedicRecord.main_display #Rails.cache.read('cur_recs')
    @messages = MedicAlert.main_display #Rails.cache.read('cur_msgs')
  end
  
  def graphs
    total = MedicRecord.count.to_f
    five_plus = (((MedicRecord.status_high.size.to_f/total) * 1000).round.to_f / 10)
    four = (((MedicRecord.with_count(4).size.to_f/total) * 1000).round.to_f / 10)
    three = (((MedicRecord.with_count(3).size.to_f/total) * 1000).round.to_f / 10)
    two = (((MedicRecord.with_count(2).size.to_f/total) * 1000).round.to_f / 10)
    one = (((MedicRecord.status_one.size.to_f/total) * 1000).round.to_f / 10)
    zero = (((MedicRecord.status_zero.size.to_f/total) * 1000).round.to_f / 10)
    @data_string = "[['Five or more',#{five_plus}],['Four',#{four}],['Three',#{three}],['Two',#{two}],['One',#{one}],['Zero',#{zero}]]"
  end
  
  def test_message
    SmsProxy.new.deliver("TEST ONLY message from medic watcher")
    flash[:notice] = "Message sent"
    redirect_to :action=>:home
  end
  
  def call_info
    if params[:id]
      @call_info = IstatusWatcher.new.fetch_call_info(params[:id].to_i)
    end
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
