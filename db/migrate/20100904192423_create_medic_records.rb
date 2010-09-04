class CreateMedicRecords < ActiveRecord::Migration
  def self.up
    create_table :medic_records do |t|
      t.integer :count

      t.timestamps
    end
  end

  def self.down
    drop_table :medic_records
  end
end
