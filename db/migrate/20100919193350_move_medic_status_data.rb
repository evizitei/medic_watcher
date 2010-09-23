class MoveMedicStatusData < ActiveRecord::Migration
  def self.up
    MedicRecord.find_each do |rec|
      if rec.m131_available
        rec.m131_status = "AVL"
      else
        rec.m131_status = "OOS"
      end
      
      if rec.m241_available
        rec.m241_status = "AVL"
      else
        rec.m241_status = "OOS"
      end
    end
  end

  def self.down
  end
end
