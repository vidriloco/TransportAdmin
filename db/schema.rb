# encoding: UTF-8
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

ActiveRecord::Schema.define(:version => 20120219064844) do

  create_table "connections", :force => true do |t|
    t.integer  "one_station_id",     :null => false
    t.integer  "another_station_id", :null => false
    t.integer  "one_line_id",        :null => false
    t.integer  "another_line_id",    :null => false
    t.integer  "length"
    t.integer  "accessibility"
    t.integer  "kind"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "connections", ["another_line_id"], :name => "another_line_id_ix"
  add_index "connections", ["another_station_id"], :name => "another_station_id_ix"
  add_index "connections", ["one_line_id"], :name => "one_line_id_ix"
  add_index "connections", ["one_station_id", "another_station_id", "one_line_id", "another_line_id"], :name => "stations_lines_id_ix", :unique => true
  add_index "connections", ["one_station_id"], :name => "one_station_id_ix"

  create_table "docking_stations", :force => true do |t|
    t.string   "name",                        :null => false
    t.integer  "transport_id"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.point    "coordinates",  :limit => nil, :null => false, :srid => 4326
  end

  create_table "lines", :force => true do |t|
    t.string   "name",           :null => false
    t.string   "right_terminal", :null => false
    t.string   "left_terminal",  :null => false
    t.integer  "transport_id",   :null => false
    t.string   "color"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "lines", ["transport_id"], :name => "transport_id_ix"

  create_table "segments", :force => true do |t|
    t.integer  "line_id",                                   :null => false
    t.integer  "origin_station_id",                         :null => false
    t.integer  "destination_station_id",                    :null => false
    t.float    "distance"
    t.boolean  "double_direction",       :default => false
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  add_index "segments", ["destination_station_id"], :name => "destination_station_id_ix"
  add_index "segments", ["origin_station_id", "destination_station_id", "line_id"], :name => "origin_destination_id_ix", :unique => true
  add_index "segments", ["origin_station_id"], :name => "origin_station_id_ix"

  create_table "stations", :force => true do |t|
    t.string   "name",                       :null => false
    t.boolean  "is_terminal"
    t.integer  "line_id"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.point    "coordinates", :limit => nil, :null => false, :srid => 4326
  end

  create_table "transports", :force => true do |t|
    t.string   "name",       :null => false
    t.string   "twitter"
    t.string   "web_page"
    t.integer  "mode",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "traversals", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "ways", :force => true do |t|
    t.string      "description"
    t.integer     "line_id",                    :null => false
    t.datetime    "created_at",                 :null => false
    t.datetime    "updated_at",                 :null => false
    t.line_string "content",     :limit => nil, :null => false, :srid => 4326
  end

  add_index "ways", ["line_id"], :name => "line_id_ix"

end
