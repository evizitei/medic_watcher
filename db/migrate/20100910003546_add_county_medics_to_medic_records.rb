class AddCountyMedicsToMedicRecords < ActiveRecord::Migration
  def self.up
    add_column :medic_records, :m131_available, :boolean
    add_column :medic_records, :m241_available, :boolean
  end

  def self.down
    remove_column :medic_records, :m241_available
    remove_column :medic_records, :m131_available
  end
end
