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

ActiveRecord::Schema.define(version: 3) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "filters", force: :cascade do |t|
    t.text "name", null: false
  end

  add_index "filters", ["name"], name: "index_filters_on_name", unique: true, using: :btree

  create_table "geo_points", force: :cascade do |t|
    t.float "lat", null: false
    t.float "lng", null: false
  end

  add_index "geo_points", ["lat", "lng"], name: "index_geo_points_on_lat_and_lng", unique: true, using: :btree

  create_table "hashtags", force: :cascade do |t|
    t.text "tag_name", null: false
  end

  create_table "locations", force: :cascade do |t|
    t.float   "lat",          null: false
    t.float   "lng",          null: false
    t.integer "instagram_id"
    t.text    "name"
  end

  add_index "locations", ["instagram_id"], name: "index_locations_on_instagram_id", unique: true, where: "(instagram_id IS NOT NULL)", using: :btree
  add_index "locations", ["lat", "lng"], name: "index_locations_on_lat_and_lng", using: :btree

  create_table "posts", force: :cascade do |t|
    t.integer "source_id",      null: false
    t.integer "user_id",        null: false
    t.text    "instagram_id",   null: false
    t.integer "location_id",    null: false
    t.integer "filter_id",      null: false
    t.integer "created_time",   null: false
    t.integer "updated_time",   null: false
    t.integer "content_type",   null: false
    t.text    "instagram_link", null: false
    t.text    "image_link",     null: false
    t.text    "video_link"
    t.integer "likes_count",    null: false
    t.integer "comments_count", null: false
    t.text    "caption"
    t.text    "source_type",    null: false
  end

  add_index "posts", ["source_type", "source_id", "instagram_id"], name: "index_posts_on_source_type_and_source_id_and_instagram_id", unique: true, using: :btree

  create_table "posts_tags", id: false, force: :cascade do |t|
    t.integer "post_id", null: false
    t.integer "tag_id",  null: false
  end

  add_index "posts_tags", ["post_id", "tag_id"], name: "index_posts_tags_on_post_id_and_tag_id", unique: true, using: :btree

  create_table "tags", force: :cascade do |t|
    t.text "name", null: false
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.integer "instagram_id", null: false
    t.text    "nick_name",    null: false
    t.text    "full_name",    null: false
    t.text    "image",        null: false
  end

  add_index "users", ["instagram_id"], name: "index_users_on_instagram_id", unique: true, using: :btree

  create_table "users_in_posts", id: false, force: :cascade do |t|
    t.integer "post_id", null: false
    t.integer "user_id", null: false
  end

  add_index "users_in_posts", ["post_id", "user_id"], name: "index_users_in_posts_on_post_id_and_user_id", unique: true, using: :btree

end
