class SmsProxy
  def deliver(message)
    sms_fu = SMSFu::Client.configure(:delivery => :action_mailer)
    [{:number=>"5732395840",:carrier=>"at&t"},
     {:number=>"5732686228",:carrier=>"sprint"}].each do |map|
      sms_fu.deliver("5732395840","at&t",message)
    end
    MedicAlert.create!(:message=>message)
  end
end