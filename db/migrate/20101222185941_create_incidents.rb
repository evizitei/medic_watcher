class CreateIncidents < ActiveRecord::Migration
  def self.up
    create_table :incidents do |t|
      t.string :address
      t.string :number
      t.string :nature
      t.string :cross_street_1
      t.string :cross_street_2
      t.string :response_level
      t.integer :priority
      t.string :dispatch_code
      t.string :grid
      t.string :tac_channel
      t.string :fire_area
      t.text :cautions
      t.datetime :alarm_struck_at
      t.datetime :first_on_scene_at
      t.datetime :upgrade_at
      t.datetime :patient_contact_at
      t.text :notes

      t.timestamps
    end
  end

  def self.down
    drop_table :incidents
  end
end
