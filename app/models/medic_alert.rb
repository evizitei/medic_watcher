class MedicAlert < ActiveRecord::Base
  def self.main_display
    MedicAlert.limit(5).order("id desc").all
  end
end
