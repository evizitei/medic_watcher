class MainController < ApplicationController
  def home
  end
  
  def test_message
    sms_fu = SMSFu::Client.configure(:delivery => :action_mailer)
    sms_fu.deliver("5732395840","at&t","testing from medic watcher")
    flash[:notice] = "Message sent"
    redirect_to :action=>:home
  end
end
