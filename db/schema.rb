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

ActiveRecord::Schema.define(version: 20150227153845) do

  create_table "accounts", force: :cascade do |t|
    t.integer  "user_id",          limit: 4
    t.string   "personal_website", limit: 255
    t.string   "location",         limit: 255
    t.string   "signature",        limit: 255
    t.text     "introduction",     limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "weibo_link",       limit: 255,   default: ""
  end

  add_index "accounts", ["user_id"], name: "index_accounts_on_user_id", using: :btree

  create_table "advertisements", force: :cascade do |t|
    t.string   "link",        limit: 255
    t.string   "banner",      limit: 255
    t.string   "title",       limit: 255
    t.string   "words",       limit: 255
    t.date     "start_date"
    t.date     "expire_date"
    t.integer  "duration",    limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "advertisements", ["expire_date"], name: "index_advertisements_on_expire_date", using: :btree
  add_index "advertisements", ["start_date"], name: "index_advertisements_on_start_date", using: :btree

  create_table "bookmarks", force: :cascade do |t|
    t.integer  "user_id",           limit: 4
    t.string   "bookmarkable_type", limit: 255
    t.integer  "bookmarkable_id",   limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bookmarks", ["bookmarkable_id", "bookmarkable_type"], name: "index_bookmarks_on_bookmarkable_id_and_bookmarkable_type", using: :btree
  add_index "bookmarks", ["user_id"], name: "index_bookmarks_on_user_id", using: :btree

  create_table "cloud_files", force: :cascade do |t|
    t.string   "content_type", limit: 255
    t.integer  "file_size",    limit: 4
    t.string   "asset",        limit: 255
    t.string   "name",         limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", force: :cascade do |t|
    t.text     "content",          limit: 65535
    t.integer  "user_id",          limit: 4
    t.string   "commentable_type", limit: 255
    t.integer  "commentable_id",   limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "posting_device",   limit: 255,   default: "", null: false
  end

  add_index "comments", ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type", using: :btree
  add_index "comments", ["created_at"], name: "index_comments_on_created_at", using: :btree
  add_index "comments", ["updated_at"], name: "index_comments_on_updated_at", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "followings", force: :cascade do |t|
    t.integer  "user_id",          limit: 4
    t.integer  "followed_user_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "followings", ["created_at"], name: "index_followings_on_created_at", using: :btree
  add_index "followings", ["followed_user_id"], name: "index_followings_on_followed_user_id", using: :btree
  add_index "followings", ["user_id", "followed_user_id"], name: "index_followings_on_user_id_and_followed_user_id", unique: true, using: :btree
  add_index "followings", ["user_id"], name: "index_followings_on_user_id", using: :btree

  create_table "nodes", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.string   "key",          limit: 255
    t.string   "introduction", limit: 255
    t.text     "custom_html",  limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "plane_id",     limit: 4
    t.integer  "position",     limit: 4
    t.integer  "topics_count", limit: 4,     default: 0,     null: false
    t.boolean  "quiet",        limit: 1,     default: false, null: false
    t.text     "custom_css",   limit: 65535
  end

  add_index "nodes", ["key"], name: "index_nodes_on_key", unique: true, using: :btree
  add_index "nodes", ["plane_id"], name: "index_nodes_on_plane_id", using: :btree
  add_index "nodes", ["position"], name: "index_nodes_on_position", using: :btree
  add_index "nodes", ["quiet"], name: "index_nodes_on_quiet", using: :btree
  add_index "nodes", ["updated_at"], name: "index_nodes_on_updated_at", using: :btree

  create_table "notifications", force: :cascade do |t|
    t.integer  "user_id",         limit: 4
    t.string   "notifiable_type", limit: 255
    t.integer  "notifiable_id",   limit: 4
    t.text     "content",         limit: 65535
    t.integer  "action_user_id",  limit: 4
    t.string   "action",          limit: 255
    t.boolean  "unread",          limit: 1,     default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notifications", ["notifiable_id", "notifiable_type"], name: "index_notifications_on_notifiable_id_and_notifiable_type", using: :btree
  add_index "notifications", ["unread"], name: "index_notifications_on_unread", using: :btree
  add_index "notifications", ["user_id"], name: "index_notifications_on_user_id", using: :btree

  create_table "pages", force: :cascade do |t|
    t.string   "key",        limit: 255
    t.string   "title",      limit: 255
    t.text     "content",    limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "published",  limit: 1,     default: false
    t.integer  "position",   limit: 4
  end

  add_index "pages", ["key"], name: "index_pages_on_key", using: :btree
  add_index "pages", ["position"], name: "index_pages_on_position", using: :btree
  add_index "pages", ["published"], name: "index_pages_on_published", using: :btree

  create_table "planes", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position",   limit: 4,   default: 0, null: false
  end

  add_index "planes", ["updated_at"], name: "index_planes_on_updated_at", using: :btree

  create_table "qiniu_images", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "size",         limit: 4
    t.string   "filename",     limit: 255
    t.string   "content_type", limit: 255
    t.integer  "user_id",      limit: 4
    t.string   "asset",        limit: 255
  end

  create_table "rewards", force: :cascade do |t|
    t.integer  "admin_user_id", limit: 4,     default: 0
    t.integer  "user_id",       limit: 4,     default: 0
    t.integer  "amount",        limit: 4,     default: 0
    t.integer  "balance",       limit: 4,     default: 0
    t.text     "reason",        limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "settings", force: :cascade do |t|
    t.string   "var",        limit: 255,   null: false
    t.text     "value",      limit: 65535
    t.integer  "thing_id",   limit: 4
    t.string   "thing_type", limit: 30
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "settings", ["thing_type", "thing_id", "var"], name: "index_settings_on_thing_type_and_thing_id_and_var", unique: true, using: :btree

  create_table "topics", force: :cascade do |t|
    t.integer  "node_id",         limit: 4
    t.integer  "user_id",         limit: 4
    t.string   "title",           limit: 255
    t.text     "content",         limit: 65535
    t.integer  "hit",             limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "involved_at"
    t.integer  "comments_count",  limit: 4,     default: 0,     null: false
    t.boolean  "comments_closed", limit: 1,     default: false, null: false
    t.boolean  "sticky",          limit: 1,     default: false
    t.string   "last_replied_by", limit: 255,   default: ""
    t.datetime "last_replied_at"
  end

  add_index "topics", ["involved_at"], name: "index_topics_on_involved_at", using: :btree
  add_index "topics", ["node_id"], name: "index_topics_on_node_id", using: :btree
  add_index "topics", ["sticky"], name: "index_topics_on_sticky", using: :btree
  add_index "topics", ["user_id"], name: "index_topics_on_user_id", using: :btree

  create_table "upyun_images", force: :cascade do |t|
    t.string   "asset",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",      limit: 4
    t.integer  "size",         limit: 4
    t.string   "filename",     limit: 255
    t.string   "content_type", limit: 255
  end

  add_index "upyun_images", ["user_id"], name: "index_upyun_images_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "",    null: false
    t.string   "encrypted_password",     limit: 255, default: "",    null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "nickname",               limit: 255
    t.string   "avatar",                 limit: 255
    t.string   "role",                   limit: 255
    t.boolean  "blocked",                limit: 1,   default: false
    t.integer  "reward",                 limit: 4,   default: 0
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["nickname"], name: "index_users_on_nickname", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["role"], name: "index_users_on_role", using: :btree

end
