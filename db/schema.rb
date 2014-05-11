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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121204032057) do

  create_table "accounts", :force => true do |t|
    t.integer  "user_id"
    t.string   "personal_website"
    t.string   "location"
    t.string   "signature"
    t.text     "introduction"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.string   "weibo_link",       :default => ""
  end

  add_index "accounts", ["user_id"], :name => "index_accounts_on_user_id"

  create_table "advertisements", :force => true do |t|
    t.string   "link"
    t.string   "banner"
    t.string   "title"
    t.string   "words"
    t.date     "start_date"
    t.date     "expire_date"
    t.integer  "duration"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "advertisements", ["expire_date"], :name => "index_advertisements_on_expire_date"
  add_index "advertisements", ["start_date"], :name => "index_advertisements_on_start_date"

  create_table "bookmarks", :force => true do |t|
    t.integer  "user_id"
    t.string   "bookmarkable_type"
    t.integer  "bookmarkable_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "bookmarks", ["bookmarkable_id", "bookmarkable_type"], :name => "index_bookmarks_on_bookmarkable_id_and_bookmarkable_type"
  add_index "bookmarks", ["user_id"], :name => "index_bookmarks_on_user_id"

  create_table "cloud_files", :force => true do |t|
    t.string   "content_type"
    t.integer  "file_size"
    t.string   "asset"
    t.string   "name"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "comments", :force => true do |t|
    t.text     "content"
    t.integer  "user_id"
    t.string   "commentable_type"
    t.integer  "commentable_id"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.string   "posting_device",   :default => "", :null => false
  end

  add_index "comments", ["commentable_id", "commentable_type"], :name => "index_comments_on_commentable_id_and_commentable_type"
  add_index "comments", ["created_at"], :name => "index_comments_on_created_at"
  add_index "comments", ["updated_at"], :name => "index_comments_on_updated_at"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "followings", :force => true do |t|
    t.integer  "user_id"
    t.integer  "followed_user_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "followings", ["created_at"], :name => "index_followings_on_created_at"
  add_index "followings", ["followed_user_id"], :name => "index_followings_on_followed_user_id"
  add_index "followings", ["user_id", "followed_user_id"], :name => "index_followings_on_user_id_and_followed_user_id", :unique => true
  add_index "followings", ["user_id"], :name => "index_followings_on_user_id"

  create_table "nodes", :force => true do |t|
    t.string   "name"
    t.string   "key"
    t.string   "introduction"
    t.text     "custom_html"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.integer  "plane_id"
    t.integer  "position"
    t.integer  "topics_count", :default => 0,     :null => false
    t.boolean  "quiet",        :default => false, :null => false
    t.text     "custom_css"
  end

  add_index "nodes", ["key"], :name => "index_nodes_on_key", :unique => true
  add_index "nodes", ["plane_id"], :name => "index_nodes_on_plane_id"
  add_index "nodes", ["position"], :name => "index_nodes_on_position"
  add_index "nodes", ["quiet"], :name => "index_nodes_on_quiet"
  add_index "nodes", ["updated_at"], :name => "index_nodes_on_updated_at"

  create_table "notifications", :force => true do |t|
    t.integer  "user_id"
    t.string   "notifiable_type"
    t.integer  "notifiable_id"
    t.text     "content"
    t.integer  "action_user_id"
    t.string   "action"
    t.boolean  "unread",          :default => true
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  add_index "notifications", ["notifiable_id", "notifiable_type"], :name => "index_notifications_on_notifiable_id_and_notifiable_type"
  add_index "notifications", ["unread"], :name => "index_notifications_on_unread"
  add_index "notifications", ["user_id"], :name => "index_notifications_on_user_id"

  create_table "pages", :force => true do |t|
    t.string   "key"
    t.string   "title"
    t.text     "content"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.boolean  "published",  :default => false
    t.integer  "position"
  end

  add_index "pages", ["key"], :name => "index_pages_on_key"
  add_index "pages", ["position"], :name => "index_pages_on_position"
  add_index "pages", ["published"], :name => "index_pages_on_published"

  create_table "planes", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.integer  "position",   :default => 0, :null => false
  end

  add_index "planes", ["updated_at"], :name => "index_planes_on_updated_at"

  create_table "rewards", :force => true do |t|
    t.integer  "admin_user_id", :default => 0
    t.integer  "user_id",       :default => 0
    t.integer  "amount",        :default => 0
    t.integer  "balance",       :default => 0
    t.text     "reason"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  create_table "settings", :force => true do |t|
    t.string   "var",                      :null => false
    t.text     "value"
    t.integer  "thing_id"
    t.string   "thing_type", :limit => 30
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  add_index "settings", ["thing_type", "thing_id", "var"], :name => "index_settings_on_thing_type_and_thing_id_and_var", :unique => true

  create_table "topics", :force => true do |t|
    t.integer  "node_id"
    t.integer  "user_id"
    t.string   "title"
    t.text     "content"
    t.integer  "hit"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.datetime "involved_at"
    t.integer  "comments_count",  :default => 0,     :null => false
    t.boolean  "comments_closed", :default => false, :null => false
    t.boolean  "sticky",          :default => false
    t.string   "last_replied_by", :default => ""
    t.datetime "last_replied_at"
  end

  add_index "topics", ["involved_at"], :name => "index_topics_on_involved_at"
  add_index "topics", ["node_id"], :name => "index_topics_on_node_id"
  add_index "topics", ["sticky"], :name => "index_topics_on_sticky"
  add_index "topics", ["user_id"], :name => "index_topics_on_user_id"

  create_table "upyun_images", :force => true do |t|
    t.string   "asset"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "user_id"
    t.integer  "size"
    t.string   "filename"
    t.string   "content_type"
  end

  add_index "upyun_images", ["user_id"], :name => "index_upyun_images_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "nickname"
    t.string   "avatar"
    t.string   "role"
    t.boolean  "blocked",                :default => false
    t.integer  "reward",                 :default => 0
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["nickname"], :name => "index_users_on_nickname", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["role"], :name => "index_users_on_role"

end
