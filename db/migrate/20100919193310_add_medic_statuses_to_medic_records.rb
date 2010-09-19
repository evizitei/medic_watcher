class AddMedicStatusesToMedicRecords < ActiveRecord::Migration
  def self.up
    add_column :medic_records, :m131_status, :string
    add_column :medic_records, :m241_status, :string
  end

  def self.down
    remove_column :medic_records, :m241_status
    remove_column :medic_records, :m131_status
  end
end
