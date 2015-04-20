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

ActiveRecord::Schema.define(version: 20150422121845) do

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

  create_table "bookings", force: true do |t|
    t.string   "status",      default: "pending"
    t.integer  "artist_id"
    t.integer  "gig_id"
    t.datetime "started_at"
    t.datetime "finished_at"
    t.boolean  "is_active",   default: false
  end

  create_table "comments", force: true do |t|
    t.text     "text"
    t.boolean  "is_active"
    t.integer  "author_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "email_notifications", force: true do |t|
    t.string   "title"
    t.string   "name"
    t.boolean  "is_active",  default: true
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "email_notifications_users", id: false, force: true do |t|
    t.integer "email_notification_id", null: false
    t.integer "user_id",               null: false
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

  create_table "genres", force: true do |t|
    t.string   "name"
    t.boolean  "is_active",  default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "genres_profiles", id: false, force: true do |t|
    t.integer "genre_id",   null: false
    t.integer "profile_id", null: false
  end

  create_table "gig_faqs", force: true do |t|
    t.text     "question"
    t.text     "answer"
    t.boolean  "is_active"
    t.integer  "gig_id"
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

  create_table "managers", force: true do |t|
    t.boolean  "is_active",  default: true
    t.integer  "profile_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photo_albums", force: true do |t|
    t.string   "title"
    t.boolean  "is_active",        default: true
    t.integer  "owner_profile_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photo_albums_photos", id: false, force: true do |t|
    t.integer "photo_album_id", null: false
    t.integer "photo_id",       null: false
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

  create_table "producers", force: true do |t|
    t.boolean  "is_active",  default: true
    t.integer  "profile_id"
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
    t.integer  "location_id"
  end

  create_table "releases", force: true do |t|
    t.string   "title"
    t.text     "description_text"
    t.datetime "published_at"
    t.boolean  "is_active"
    t.integer  "artist_id"
    t.integer  "photo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
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

  create_table "songs", force: true do |t|
    t.string   "attachment_uid"
    t.string   "source"
    t.string   "source_id"
    t.integer  "duration"
    t.string   "title"
    t.datetime "published_at"
    t.boolean  "is_active"
    t.integer  "uploader_id"
    t.integer  "release_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_contacts", force: true do |t|
    t.string  "first_phone"
    t.string  "second_phone"
    t.string  "fax"
    t.integer "user_id"
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

  create_table "venues", force: true do |t|
    t.boolean  "is_active",  default: true
    t.integer  "profile_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "videos", force: true do |t|
    t.string   "attachment_uid"
    t.string   "source"
    t.string   "source_id"
    t.integer  "duration"
    t.string   "title"
    t.text     "description_text"
    t.boolean  "is_active"
    t.integer  "uploader_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_foreign_key "artists", "profiles", name: "artists_profile_id_fk", dependent: :delete

  add_foreign_key "awards", "photos", name: "awards_photo_id_fk"
  add_foreign_key "awards", "profiles", name: "awards_owner_profile_id_fk", column: "owner_profile_id"

  add_foreign_key "bookings", "artists", name: "artists_gigs_artist_id_fk", dependent: :delete
  add_foreign_key "bookings", "gigs", name: "artists_gigs_gig_id_fk", dependent: :delete

  add_foreign_key "comments", "users", name: "comments_author_id_fk", column: "author_id"

  add_foreign_key "email_notifications_users", "email_notifications", name: "email_notifications_users_email_notification_id_fk", dependent: :delete
  add_foreign_key "email_notifications_users", "users", name: "email_notifications_users_user_id_fk", dependent: :delete

  add_foreign_key "genres_profiles", "genres", name: "genres_profiles_genre_id_fk", dependent: :delete
  add_foreign_key "genres_profiles", "profiles", name: "genres_profiles_profile_id_fk", dependent: :delete

  add_foreign_key "gig_faqs", "gigs", name: "gig_faqs_gig_id_fk", dependent: :delete

  add_foreign_key "gigs", "locations", name: "gigs_location_id_fk"
  add_foreign_key "gigs", "photos", name: "gigs_photo_id_fk"
  add_foreign_key "gigs", "profiles", name: "gigs_owner_profile_id_fk", column: "owner_profile_id"

  add_foreign_key "identities", "users", name: "identities_user_id_fk", dependent: :delete

  add_foreign_key "labels", "profiles", name: "labels_profile_id_fk", dependent: :delete

  add_foreign_key "managers", "profiles", name: "managers_profile_id_fk", dependent: :delete

  add_foreign_key "photo_albums", "profiles", name: "photo_albums_owner_profile_id_fk", column: "owner_profile_id"

  add_foreign_key "photo_albums_photos", "photo_albums", name: "photo_albums_photos_photo_album_id_fk", dependent: :delete
  add_foreign_key "photo_albums_photos", "photos", name: "photo_albums_photos_photo_id_fk", dependent: :delete

  add_foreign_key "photos", "users", name: "photos_uploader_id_fk", column: "uploader_id"

  add_foreign_key "producers", "profiles", name: "producers_profile_id_fk", dependent: :delete

  add_foreign_key "profiles", "locations", name: "profiles_location_id_fk"
  add_foreign_key "profiles", "photos", name: "profiles_photo_id_fk"
  add_foreign_key "profiles", "photos", name: "profiles_wallpaper_id_fk", column: "wallpaper_id"
  add_foreign_key "profiles", "users", name: "profiles_user_id_fk", dependent: :delete

  add_foreign_key "releases", "artists", name: "releases_artist_id_fk"
  add_foreign_key "releases", "photos", name: "releases_photo_id_fk"

  add_foreign_key "roles_users", "roles", name: "roles_users_role_id_fk", dependent: :delete
  add_foreign_key "roles_users", "users", name: "roles_users_user_id_fk", dependent: :delete

  add_foreign_key "songs", "releases", name: "songs_release_id_fk"
  add_foreign_key "songs", "users", name: "songs_uploader_id_fk", column: "uploader_id"

  add_foreign_key "venues", "profiles", name: "venues_profile_id_fk", dependent: :delete

  add_foreign_key "videos", "users", name: "videos_uploader_id_fk", column: "uploader_id"

end
