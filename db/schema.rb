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

ActiveRecord::Schema.define(version: 20160408140413) do

  create_table "feedbacks", force: :cascade do |t|
    t.string   "message",    limit: 255
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "route_suggestions", force: :cascade do |t|
    t.string   "name",       limit: 255, null: false
    t.integer  "threshold",  limit: 4,   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "route_suggestions_pledges", force: :cascade do |t|
    t.integer  "user_id",                        limit: 4,   null: false
    t.boolean  "approved",                       limit: 1
    t.string   "lat",                            limit: 255, null: false
    t.string   "long",                           limit: 255, null: false
    t.integer  "is_pledge",                      limit: 4
    t.integer  "route_suggestions_slot_id",      limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "route_suggestions_timestamp_id", limit: 4
  end

  add_index "route_suggestions_pledges", ["route_suggestions_slot_id"], name: "fk_rails_21937d8705", using: :btree
  add_index "route_suggestions_pledges", ["route_suggestions_timestamp_id"], name: "fk_rails_ec23c55f37", using: :btree

  create_table "route_suggestions_route_points", force: :cascade do |t|
    t.string   "lat",                 limit: 255
    t.string   "long",                limit: 255
    t.integer  "route_suggestion_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "pickup_point_id",     limit: 4
    t.integer  "drop_point_id",       limit: 4
  end

  add_index "route_suggestions_route_points", ["route_suggestion_id"], name: "fk_rails_348cada1dc", using: :btree

  create_table "route_suggestions_slots", force: :cascade do |t|
    t.string   "name",                limit: 255, null: false
    t.string   "lat",                 limit: 255, null: false
    t.string   "long",                limit: 255, null: false
    t.integer  "time",                limit: 4,   null: false
    t.integer  "route_suggestion_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "route_suggestions_slots", ["route_suggestion_id"], name: "fk_rails_e44f9a2b1f", using: :btree

  create_table "route_suggestions_timestamps", force: :cascade do |t|
    t.time     "time_departure"
    t.integer  "route_suggestion_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "route_suggestions_timestamps", ["route_suggestion_id"], name: "fk_rails_a56260d126", using: :btree

  add_foreign_key "route_suggestions_pledges", "route_suggestions_slots"
  add_foreign_key "route_suggestions_pledges", "route_suggestions_timestamps"
  add_foreign_key "route_suggestions_route_points", "route_suggestions"
  add_foreign_key "route_suggestions_slots", "route_suggestions"
  add_foreign_key "route_suggestions_timestamps", "route_suggestions"
end
