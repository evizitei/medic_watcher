# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20101222185941) do

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.text     "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "incidents", :force => true do |t|
    t.string   "address"
    t.string   "number"
    t.string   "nature"
    t.string   "cross_street_1"
    t.string   "cross_street_2"
    t.string   "response_level"
    t.integer  "priority"
    t.string   "dispatch_code"
    t.string   "grid"
    t.string   "tac_channel"
    t.string   "fire_area"
    t.text     "cautions"
    t.datetime "alarm_struck_at"
    t.datetime "first_on_scene_at"
    t.datetime "upgrade_at"
    t.datetime "patient_contact_at"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "medic_alerts", :force => true do |t|
    t.string   "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "medic_records", :force => true do |t|
    t.integer  "count"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "m131_available"
    t.boolean  "m241_available"
    t.string   "m131_status"
    t.string   "m241_status"
  end

  add_index "medic_records", ["count"], :name => "index_medic_records_on_count"

end
