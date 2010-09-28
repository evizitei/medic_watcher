class SmsProxy
  def deliver(message)
    now_time = Time.now
    sms_fu = SMSFu::Client.configure(:delivery => :action_mailer)
    [{:number=>"5732395840",:carrier=>"at&t",:start=>"07:00:00",:stop=>"15:00:00"},
     {:number=>"5732686228",:carrier=>"sprint",:start=>"05:00:00",:stop=>"21:00:00"},
     {:number=>"5733031624",:carrier=>"sprint",:start=>"05:00:00",:stop=>"17:00:00"},
     {:number=>"5732685942",:carrier=>"sprint",:start=>"05:00:00",:stop=>"21:00:00"}].each do |map|
      start_time = Time.parse(map[:start])
      stop_time = Time.parse(map[:stop])
      if now_time >= start_time and now_time <= stop_time
        sms_fu.deliver(map[:number],map[:carrier],message)
      end
    end
    MedicAlert.create!(:message=>message)
  end
end