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

ActiveRecord::Schema.define(version: 20160420132330) do

  create_table "customer_routes", force: :cascade do |t|
    t.string   "lat",        limit: 255
    t.string   "long",       limit: 255
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "destination_clusters", force: :cascade do |t|
    t.float    "lat",        limit: 24
    t.float    "lng",        limit: 24
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.float    "radius",     limit: 24
    t.integer  "people",     limit: 4
  end

  create_table "feedbacks", force: :cascade do |t|
    t.string   "message",    limit: 255
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "locations", force: :cascade do |t|
    t.integer  "clusterid",   limit: 4
    t.string   "name",        limit: 255
    t.datetime "created_at",                                                        null: false
    t.datetime "updated_at",                                                        null: false
    t.decimal  "lat",                     precision: 16, scale: 10
    t.decimal  "lng",                     precision: 16, scale: 10
    t.string   "image",       limit: 255
    t.string   "icon_image",  limit: 255
    t.string   "left",        limit: 255
    t.string   "right",       limit: 255
    t.string   "category",    limit: 255
    t.string   "locality",    limit: 255
    t.string   "landmark",    limit: 255
    t.string   "closeby",     limit: 255
    t.integer  "global_rank", limit: 4,                             default: -1,    null: false
    t.boolean  "deleted",     limit: 1,                             default: false, null: false
  end

  add_index "locations", ["lat", "lng"], name: "lat_lng_index", using: :btree

  create_table "pick_point_clusters", force: :cascade do |t|
    t.float    "lat",        limit: 24
    t.float    "lng",        limit: 24
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.float    "radius",     limit: 24
    t.integer  "people",     limit: 4
  end

  create_table "route_dist_times", force: :cascade do |t|
    t.integer  "routeid",    limit: 4
    t.integer  "routeidD",   limit: 4
    t.float    "distance",   limit: 24
    t.integer  "duration",   limit: 4
    t.integer  "eval_time",  limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "route_dists", force: :cascade do |t|
    t.integer  "routeid",    limit: 4
    t.integer  "routeidD",   limit: 4
    t.float    "distance",   limit: 24
    t.integer  "duration",   limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "route_points", force: :cascade do |t|
    t.float    "lat",         limit: 53
    t.float    "lng",         limit: 53
    t.integer  "routeid",     limit: 4
    t.datetime "created_at"
    t.datetime "updated_at",                         null: false
    t.integer  "directionid", limit: 4,  default: 0
    t.integer  "locationid",  limit: 4,  default: 0
  end

  add_index "route_points", ["routeid"], name: "routeid", using: :btree

  create_table "route_suggestions", force: :cascade do |t|
    t.string   "name",       limit: 255, null: false
    t.integer  "threshold",  limit: 4,   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "route_suggestions_customers", force: :cascade do |t|
    t.float    "from_lat",        limit: 24
    t.float    "from_long",       limit: 24
    t.float    "to_lat",          limit: 24
    t.float    "to_long",         limit: 24
    t.string   "time1",           limit: 255
    t.string   "time2",           limit: 255
    t.string   "phone",           limit: 255
    t.string   "mode",            limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "pick_cluster_id", limit: 4
    t.integer  "drop_cluster_id", limit: 4
    t.string   "description",     limit: 255
  end

  create_table "route_suggestions_otps", force: :cascade do |t|
    t.string   "phone",      limit: 255
    t.string   "otp",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "route_suggestions_pledges", force: :cascade do |t|
    t.integer  "user_id",                        limit: 4
    t.boolean  "approved",                       limit: 1
    t.string   "lat",                            limit: 255, null: false
    t.string   "long",                           limit: 255, null: false
    t.integer  "is_pledge",                      limit: 4
    t.integer  "route_suggestions_slot_id",      limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "route_suggestions_timestamp_id", limit: 4
    t.string   "phone",                          limit: 255
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

  create_table "route_suggestions_routes", force: :cascade do |t|
    t.string   "start",          limit: 255
    t.string   "stop",           limit: 255
    t.string   "name",           limit: 255
    t.string   "people",         limit: 255
    t.string   "route_type",     limit: 255
    t.integer  "points",         limit: 4
    t.string   "distance",       limit: 255
    t.string   "eta",            limit: 255
    t.string   "price",          limit: 255
    t.string   "potential",      limit: 255
    t.string   "pledge",         limit: 255
    t.integer  "feedback_count", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state",          limit: 255
    t.string   "status",         limit: 255
    t.text     "slots",          limit: 65535
  end

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

  create_table "routes", force: :cascade do |t|
    t.string   "name",                limit: 255
    t.string   "fromlocation",        limit: 255
    t.string   "tolocation",          limit: 255
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.string   "via",                 limit: 255
    t.integer  "reverseroute",        limit: 4
    t.text     "timeslot",            limit: 65535
    t.integer  "fare",                limit: 4
    t.integer  "booking_before_mins", limit: 2,     default: -1,    null: false
    t.boolean  "deleted",             limit: 1,     default: false, null: false
    t.integer  "distance_in_meters",  limit: 8,     default: 0,     null: false
  end

  add_index "routes", ["name"], name: "routename_index", using: :btree

  create_table "slots", force: :cascade do |t|
    t.string   "routeid",          limit: 255
    t.string   "locationid",       limit: 255
    t.integer  "timeinmins",       limit: 4
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.boolean  "deleted",          limit: 1,   default: false, null: false
    t.integer  "distanceinmeters", limit: 8,   default: 0
  end

  add_index "slots", ["locationid"], name: "slots_locationid", using: :btree
  add_index "slots", ["routeid"], name: "routeid", using: :btree
  add_index "slots", ["routeid"], name: "slots_routeid", using: :btree

  create_table "timestamps", force: :cascade do |t|
    t.string   "routeid",  limit: 255
    t.datetime "fromtime"
    t.datetime "totime"
    t.integer  "interval", limit: 4
    t.boolean  "deleted",  limit: 1,   default: false, null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.integer  "amount",       limit: 4
    t.text     "phone_number", limit: 65535
    t.integer  "status_code",  limit: 4
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_foreign_key "route_suggestions_pledges", "route_suggestions_slots"
  add_foreign_key "route_suggestions_pledges", "route_suggestions_timestamps"
  add_foreign_key "route_suggestions_route_points", "route_suggestions"
  add_foreign_key "route_suggestions_slots", "route_suggestions"
  add_foreign_key "route_suggestions_timestamps", "route_suggestions"
end
