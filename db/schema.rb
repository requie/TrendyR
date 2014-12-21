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

ActiveRecord::Schema.define(version: 20141219085726) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "artists", force: true do |t|
    t.boolean  "is_active",   default: true
    t.integer  "profile_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_featured", default: false
  end

  create_table "awards", force: true do |t|
    t.string   "title"
    t.text     "description_text"
    t.datetime "earned_at"
    t.boolean  "is_active",        default: true
    t.integer  "owner_profile_id"
    t.integer  "photo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: true do |t|
    t.string   "title"
    t.text     "description_text"
    t.decimal  "price"
    t.datetime "started_at"
    t.datetime "finished_at"
    t.boolean  "is_active",        default: true
    t.integer  "owner_profile_id"
    t.integer  "location_id"
    t.integer  "photo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "features", force: true do |t|
    t.string   "title"
    t.integer  "weight",     default: 0
    t.boolean  "is_active",  default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "gigs", force: true do |t|
    t.string   "title"
    t.decimal  "price"
    t.text     "overview_text"
    t.text     "opportunity_text"
    t.text     "band_text"
    t.text     "gig_text"
    t.text     "terms_text"
    t.datetime "started_at"
    t.datetime "finished_at"
    t.boolean  "is_active",        default: true
    t.integer  "owner_profile_id"
    t.integer  "location_id"
    t.integer  "photo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_featured",      default: false
  end

  create_table "identities", force: true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "token"
    t.string   "secret"
    t.text     "data"
    t.datetime "token_expires_at"
    t.boolean  "is_active",        default: true
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "labels", force: true do |t|
    t.boolean  "is_active",  default: true
    t.integer  "profile_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", force: true do |t|
    t.string   "source"
    t.string   "source_id"
    t.string   "source_place_id"
    t.string   "address"
    t.string   "types"
    t.decimal  "latitude"
    t.decimal  "longitude"
    t.integer  "creator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photos", force: true do |t|
    t.integer  "crop_x"
    t.integer  "crop_y"
    t.integer  "crop_w"
    t.integer  "crop_h"
    t.integer  "uploader_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "attachment_uid"
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
    t.integer  "location_id"
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.boolean  "is_active",  default: true
    t.boolean  "is_public",  default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", id: false, force: true do |t|
    t.integer "role_id", null: false
    t.integer "user_id", null: false
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",   null: false
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "is_active",              default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password",     default: "",   null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "artists", "profiles", name: "artists_profile_id_fk", dependent: :delete

  add_foreign_key "awards", "photos", name: "awards_photo_id_fk"
  add_foreign_key "awards", "profiles", name: "awards_owner_profile_id_fk", column: "owner_profile_id"

  add_foreign_key "events", "locations", name: "events_location_id_fk"
  add_foreign_key "events", "photos", name: "events_photo_id_fk"
  add_foreign_key "events", "profiles", name: "events_owner_profile_id_fk", column: "owner_profile_id"

  add_foreign_key "gigs", "locations", name: "gigs_location_id_fk"
  add_foreign_key "gigs", "photos", name: "gigs_photo_id_fk"
  add_foreign_key "gigs", "profiles", name: "gigs_owner_profile_id_fk", column: "owner_profile_id"

  add_foreign_key "identities", "users", name: "identities_user_id_fk", dependent: :delete

  add_foreign_key "labels", "profiles", name: "labels_profile_id_fk", dependent: :delete

  add_foreign_key "locations", "users", name: "locations_creator_id_fk", column: "creator_id"

  add_foreign_key "photos", "users", name: "photos_uploader_id_fk", column: "uploader_id"

  add_foreign_key "profiles", "locations", name: "profiles_location_id_fk"
  add_foreign_key "profiles", "photos", name: "profiles_photo_id_fk"
  add_foreign_key "profiles", "photos", name: "profiles_wallpaper_id_fk", column: "wallpaper_id"
  add_foreign_key "profiles", "users", name: "profiles_user_id_fk", dependent: :delete

  add_foreign_key "roles_users", "roles", name: "roles_users_role_id_fk", dependent: :delete
  add_foreign_key "roles_users", "users", name: "roles_users_user_id_fk", dependent: :delete

end
