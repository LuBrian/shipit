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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150816222128) do

  create_table "packages", force: :cascade do |t|
    t.string   "title"
    t.string   "origin"
    t.string   "destination"
    t.integer  "length"
    t.integer  "width"
    t.integer  "height"
    t.text     "notes"
    t.integer  "customer_id"
    t.integer  "driver_id"
    t.string   "recipient"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "assigned_time"
    t.datetime "pick_up_time"
    t.datetime "delivery_time"
    t.float    "distance"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "password_hash"
    t.string "phone_number"
    t.string "type"
    t.string "license"
    t.string "province"
    t.string "avatar"
    t.string "license_expiry"
    t.float  "latitude"
    t.float  "longitude"
  end

end
