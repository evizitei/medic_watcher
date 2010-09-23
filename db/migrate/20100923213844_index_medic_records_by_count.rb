class IndexMedicRecordsByCount < ActiveRecord::Migration
  def self.up
    add_index :medic_records,"count"
  end

  def self.down
    remove_index :medic_records,"count"
  end
end
