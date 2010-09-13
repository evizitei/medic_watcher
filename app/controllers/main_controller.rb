class MainController < ApplicationController
  caches_page :home
  cache_sweeper :medic_sweeper
  
  def home
    Time.zone = "America/Chicago"
  end
  
  def test_message
    SmsProxy.new.deliver("TEST ONLY message from medic watcher")
    flash[:notice] = "Message sent"
    redirect_to :action=>:home
  end
end
