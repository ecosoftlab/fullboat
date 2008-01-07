# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 15) do

  create_table "albums", :force => true do |t|
    t.integer  "artist_id"
    t.integer  "label_id"
    t.integer  "promoter_id"
    t.integer  "format_id"
    t.integer  "genre_id"
    t.string   "name"
    t.string   "status"
    t.date     "status_changed_on"
    t.boolean  "is_compilation"
    t.date     "released_on"
    t.text     "tracks"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "albums", ["name"], :name => "index_albums_on_name"

  create_table "artists", :force => true do |t|
    t.string   "name"
    t.string   "sort_name"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "artists", ["name"], :name => "index_artists_on_name"

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "formats", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "formats", ["name"], :name => "index_formats_on_name"

  create_table "genres", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "genres", ["name"], :name => "index_genres_on_name"

  create_table "labels", :force => true do |t|
    t.string   "name"
    t.string   "contact_name"
    t.string   "email"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "country"
    t.string   "fax"
    t.string   "phone"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "labels", ["name"], :name => "index_labels_on_name"

  create_table "playlists", :force => true do |t|
    t.integer  "user_id"
    t.integer  "program_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.text     "note"
  end

  create_table "programs", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "day"
    t.integer  "start_hour"
    t.integer  "end_hour"
    t.string   "type"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "programs_users", :id => false, :force => true do |t|
    t.integer "program_id"
    t.integer "user_id"
  end

  create_table "promoters", :force => true do |t|
    t.string   "name"
    t.string   "contact_name"
    t.string   "email"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "promoters", ["name"], :name => "index_promoters_on_name"

  create_table "reviews", :force => true do |t|
    t.text     "body"
    t.integer  "user_id"
    t.integer  "album_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reviews", ["user_id", "album_id"], :name => "index_reviews_on_user_id_and_album_id"
  add_index "reviews", ["album_id"], :name => "index_reviews_on_album_id", :unique => true
  add_index "reviews", ["user_id"], :name => "index_reviews_on_user_id"

  create_table "roles", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.datetime "created_at"
  end

  add_index "taggings", ["taggable_id", "taggable_type"], :name => "index_taggings_on_taggable_id_and_taggable_type"
  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "users", :force => true do |t|
    t.string   "type"
    t.string   "login"
    t.string   "email"
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.string   "status"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone"
    t.date     "joined_on"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.string   "activation_code",           :limit => 40
    t.datetime "activated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
