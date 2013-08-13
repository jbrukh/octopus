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

ActiveRecord::Schema.define(version: 20130807005615) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "experiments", force: true do |t|
    t.integer  "media_id",    null: false
    t.string   "media_type",  null: false
    t.integer  "user_id",     null: false
    t.string   "name",        null: false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "media", force: true do |t|
    t.integer  "user_id",           null: false
    t.string   "type",              null: false
    t.string   "name",              null: false
    t.string   "description"
    t.string   "data_file_name"
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.datetime "data_updated_at"
    t.datetime "trashed_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "media", ["type"], name: "index_media_on_type", using: :btree
  add_index "media", ["user_id"], name: "index_media_on_user_id", using: :btree

  create_table "participants", force: true do |t|
    t.integer  "user_id",    null: false
    t.string   "first_name", null: false
    t.string   "last_name",  null: false
    t.string   "email",      null: false
    t.string   "gender",     null: false
    t.date     "birthday",   null: false
    t.hstore   "properties"
    t.datetime "trashed_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "participants", ["email"], name: "index_participants_on_email", unique: true, using: :btree

  create_table "recordings", force: true do |t|
    t.integer  "user_id",           null: false
    t.integer  "participant_id"
    t.string   "state",             null: false
    t.text     "name"
    t.text     "description"
    t.integer  "duration_ms"
    t.string   "data_file_name"
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.datetime "data_updated_at"
    t.datetime "trashed_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", force: true do |t|
    t.integer  "recording_id", null: false
    t.integer  "user_id",      null: false
    t.string   "name",         null: false
    t.integer  "from_ms",      null: false
    t.integer  "to_ms",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trials", force: true do |t|
    t.integer  "user_id",       null: false
    t.integer  "experiment_id", null: false
    t.integer  "recording_id",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",      null: false
    t.string   "encrypted_password",     default: "",      null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "authentication_token"
    t.string   "first_name",                               null: false
    t.string   "last_name",                                null: false
    t.string   "role",                   default: "guest", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

end
