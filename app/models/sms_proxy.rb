class SmsProxy
  def deliver(message)
    start_time = Time.parse("05:00:00")
    stop_time = Time.parse("21:00:00")
    now_time = Time.now
    sms_fu = SMSFu::Client.configure(:delivery => :action_mailer)
    [{:number=>"5732395840",:carrier=>"at&t"},
     {:number=>"5732686228",:carrier=>"sprint"},
     {:number=>"5733031624",:carrier=>"sprint"},
     {:number=>"5732685942",:carrier=>"sprint"}].each do |map|
      if now_time >= start_time and now_time <= stop_time
        sms_fu.deliver(map[:number],map[:carrier],message)
      end
    end
    MedicAlert.create!(:message=>message)
  end
end