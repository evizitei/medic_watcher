class SmsProxy
  def deliver(message)
    sms_fu = SMSFu::Client.configure(:delivery => :action_mailer)
    sms_fu.deliver("5732395840","at&t",message)
  end
end