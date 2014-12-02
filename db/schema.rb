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

ActiveRecord::Schema.define(version: 20141202120043) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "photos", force: true do |t|
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.integer  "crop_x"
    t.integer  "crop_y"
    t.integer  "crop_w"
    t.integer  "crop_h"
    t.integer  "uploader_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "profiles", force: true do |t|
    t.string   "name"
    t.string   "website"
    t.text     "description_text"
    t.string   "spotify_url"
    t.string   "rdio_url"
    t.string   "facebook_url"
    t.string   "twitter_url"
    t.string   "google_plus_url"
    t.string   "instagram_url"
    t.boolean  "is_active",        default: true
    t.integer  "user_id"
    t.integer  "photo_id"
    t.integer  "wallpaper_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "is_active",  default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  add_foreign_key "photos", "users", name: "photos_uploader_id_fk", column: "uploader_id"

  add_foreign_key "profiles", "photos", name: "profiles_photo_id_fk"
  add_foreign_key "profiles", "photos", name: "profiles_wallpaper_id_fk", column: "wallpaper_id"
  add_foreign_key "profiles", "users", name: "profiles_user_id_fk"

end
