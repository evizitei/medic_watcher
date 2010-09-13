class MainController < ApplicationController
  
  def home
    Time.zone = "America/Chicago"
    prime_cache
    @records = Rails.cache.read('cur_recs')
    @messages = Rails.cache.read('cur_msgs')
  end
  
  def test_message
    SmsProxy.new.deliver("TEST ONLY message from medic watcher")
    flash[:notice] = "Message sent"
    redirect_to :action=>:home
  end
  
protected
  def prime_cache
    if Rails.cache.read('cur_recs').nil?
      Rails.cache.write('cur_recs',MedicRecord.main_display) 
    end
    if Rails.cache.read('cur_msgs').nil?
      Rails.cache.write('cur_msgs',MedicAlert.main_display) 
    end
  end
end
