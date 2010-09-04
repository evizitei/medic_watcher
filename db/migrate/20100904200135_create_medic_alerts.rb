class CreateMedicAlerts < ActiveRecord::Migration
  def self.up
    create_table :medic_alerts do |t|
      t.string :message
      t.timestamps
    end
  end

  def self.down
    drop_table :medic_alerts
  end
end
