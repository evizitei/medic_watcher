class MainController < ApplicationController
  def home
  end
  
  def test_message
    SmsProxy.new.deliver("testing from medic watcher")
    flash[:notice] = "Message sent"
    redirect_to :action=>:home
  end
end
