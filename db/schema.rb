# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20080727000000) do

  create_table "albums", :force => true do |t|
    t.integer  "artist_id"
    t.integer  "label_id"
    t.integer  "genre_id"
    t.string   "name"
    t.string   "sort_name"
    t.string   "status"
    t.string   "format"
    t.boolean  "is_compilation"
    t.date     "released_on"
    t.text     "tracks"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "cover_file_name"
    t.string   "cover_content_type"
    t.integer  "cover_file_size"
    t.string   "uuid"
  end

  add_index "albums", ["artist_id"], :name => "index_albums_on_artist_id"
  add_index "albums", ["name"], :name => "index_albums_on_name"

  create_table "artists", :force => true do |t|
    t.string   "name"
    t.string   "sort_name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "uuid"
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

  create_table "events", :force => true do |t|
    t.string   "name"
    t.string   "type"
    t.string   "location"
    t.text     "description"
    t.string   "phone"
    t.string   "url"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "formats", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "icon_file_name"
    t.string   "icon_content_type"
    t.integer  "icon_file_size"
  end

  add_index "formats", ["name"], :name => "index_formats_on_name"

  create_table "genres", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "icon_file_name"
    t.string   "icon_content_type"
    t.integer  "icon_file_size"
  end

  add_index "genres", ["name"], :name => "index_genres_on_name"

  create_table "labels", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "street"
    t.string   "extended"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "country"
    t.string   "fax"
    t.string   "phone"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "uuid"
  end

  add_index "labels", ["name"], :name => "index_labels_on_name"

  create_table "playlists", :force => true do |t|
    t.integer  "user_id"
    t.integer  "program_id"
    t.datetime "starts_at"
    t.datetime "ends_at"
  end

  create_table "plays", :force => true do |t|
    t.string   "name"
    t.integer  "position"
    t.integer  "playlist_id"
    t.integer  "playable_id"
    t.string   "playable_type"
    t.boolean  "is_request"
    t.boolean  "is_bincut"
    t.boolean  "is_live"
    t.boolean  "is_marked"
    t.integer  "duration"
    t.datetime "created_at"
  end

  create_table "programs", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "type"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "programs", ["name"], :name => "index_programs_on_name"

  create_table "programs_users", :id => false, :force => true do |t|
    t.integer "program_id"
    t.integer "user_id"
  end

  create_table "promos", :force => true do |t|
    t.integer  "promotable_id"
    t.string   "promotable_type"
    t.string   "name"
    t.text     "body"
    t.string   "code"
    t.integer  "duration"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "psas", :force => true do |t|
    t.string   "name"
    t.text     "body"
    t.string   "code"
    t.integer  "duration"
    t.boolean  "is_live"
    t.datetime "expires_on"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reviews", :force => true do |t|
    t.text     "body"
    t.integer  "user_id"
    t.integer  "album_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reviews", ["album_id"], :name => "index_reviews_on_album_id", :unique => true
  add_index "reviews", ["user_id", "album_id"], :name => "index_reviews_on_user_id_and_album_id"
  add_index "reviews", ["user_id"], :name => "index_reviews_on_user_id"

  create_table "roles", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer  "role_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "schedules", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.boolean  "is_current"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "slots", :force => true do |t|
    t.integer  "schedule_id"
    t.integer  "program_id"
    t.integer  "day"
    t.time     "start_time"
    t.time     "end_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.string   "status"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "dj_name"
    t.string   "phone"
    t.date     "joined_on"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.string   "activation_code",           :limit => 40
    t.datetime "activated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
  end

end
