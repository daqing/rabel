# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2023_04_17_145059) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "personal_website"
    t.string "location"
    t.string "signature"
    t.text "introduction"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.string "weibo_link", default: ""
    t.index ["user_id"], name: "index_accounts_on_user_id"
  end

  create_table "advertisements", id: :serial, force: :cascade do |t|
    t.string "link"
    t.string "banner"
    t.string "title"
    t.string "words"
    t.date "start_date"
    t.date "expire_date"
    t.integer "duration"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.index ["expire_date"], name: "index_advertisements_on_expire_date"
    t.index ["start_date"], name: "index_advertisements_on_start_date"
  end

  create_table "bookmarks", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "bookmarkable_type"
    t.integer "bookmarkable_id"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.index ["bookmarkable_id", "bookmarkable_type"], name: "index_bookmarks_on_bookmarkable_id_and_bookmarkable_type"
    t.index ["user_id"], name: "index_bookmarks_on_user_id"
  end

  create_table "channels", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "checkins", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.date "checkin_date"
    t.index ["checkin_date"], name: "index_checkins_on_checkin_date"
    t.index ["user_id"], name: "index_checkins_on_user_id"
  end

  create_table "cloud_files", id: :serial, force: :cascade do |t|
    t.string "content_type"
    t.integer "file_size"
    t.string "asset"
    t.string "name"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
  end

  create_table "comments", id: :serial, force: :cascade do |t|
    t.text "content"
    t.integer "user_id"
    t.string "commentable_type"
    t.integer "commentable_id"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.string "posting_device", default: "", null: false
    t.index ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type"
    t.index ["created_at"], name: "index_comments_on_created_at"
    t.index ["updated_at"], name: "index_comments_on_updated_at"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "followings", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "followed_user_id"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.index ["created_at"], name: "index_followings_on_created_at"
    t.index ["followed_user_id"], name: "index_followings_on_followed_user_id"
    t.index ["user_id", "followed_user_id"], name: "index_followings_on_user_id_and_followed_user_id", unique: true
    t.index ["user_id"], name: "index_followings_on_user_id"
  end

  create_table "nav_links", force: :cascade do |t|
    t.string "title"
    t.string "url"
    t.integer "position", default: 0
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "nodes", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "key"
    t.string "introduction"
    t.text "custom_html"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.integer "plane_id"
    t.integer "position"
    t.integer "topics_count", default: 0, null: false
    t.boolean "quiet", default: false, null: false
    t.text "custom_css"
    t.index ["key"], name: "index_nodes_on_key", unique: true
    t.index ["plane_id"], name: "index_nodes_on_plane_id"
    t.index ["position"], name: "index_nodes_on_position"
    t.index ["quiet"], name: "index_nodes_on_quiet"
    t.index ["updated_at"], name: "index_nodes_on_updated_at"
  end

  create_table "notifications", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "notifiable_type"
    t.integer "notifiable_id"
    t.text "content"
    t.integer "action_user_id"
    t.string "action"
    t.boolean "unread", default: true
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.index ["notifiable_id", "notifiable_type"], name: "index_notifications_on_notifiable_id_and_notifiable_type"
    t.index ["unread"], name: "index_notifications_on_unread"
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "pages", id: :serial, force: :cascade do |t|
    t.string "key"
    t.string "title"
    t.text "content"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.boolean "published", default: false
    t.integer "position"
    t.index ["key"], name: "index_pages_on_key"
    t.index ["position"], name: "index_pages_on_position"
    t.index ["published"], name: "index_pages_on_published"
  end

  create_table "planes", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.integer "position", default: 0, null: false
    t.index ["updated_at"], name: "index_planes_on_updated_at"
  end

  create_table "qiniu_images", id: :serial, force: :cascade do |t|
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.integer "size"
    t.string "filename"
    t.string "content_type"
    t.integer "user_id"
    t.string "asset"
  end

  create_table "rewards", id: :serial, force: :cascade do |t|
    t.integer "admin_user_id", default: 0
    t.integer "user_id", default: 0
    t.integer "amount", default: 0
    t.integer "balance", default: 0
    t.text "reason"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
  end

  create_table "settings", id: :serial, force: :cascade do |t|
    t.string "var", null: false
    t.text "value"
    t.integer "thing_id"
    t.string "thing_type", limit: 30
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.index ["thing_type", "thing_id", "var"], name: "index_settings_on_thing_type_and_thing_id_and_var", unique: true
  end

  create_table "side_blocks", force: :cascade do |t|
    t.string "name"
    t.text "body"
    t.integer "position", default: 0
    t.boolean "on_homepage", default: false
    t.boolean "on_otherpage", default: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "topics", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "title"
    t.text "content"
    t.integer "hit"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.datetime "involved_at", precision: nil
    t.integer "comments_count", default: 0, null: false
    t.boolean "comments_closed", default: false, null: false
    t.boolean "sticky", default: false
    t.string "last_replied_by", default: ""
    t.datetime "last_replied_at", precision: nil
    t.integer "channel_id"
    t.index ["channel_id"], name: "index_topics_on_channel_id"
    t.index ["involved_at"], name: "index_topics_on_involved_at"
    t.index ["sticky"], name: "index_topics_on_sticky"
    t.index ["user_id"], name: "index_topics_on_user_id"
  end

  create_table "upyun_images", id: :serial, force: :cascade do |t|
    t.string "asset"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.integer "user_id"
    t.integer "size"
    t.string "filename"
    t.string "content_type"
    t.index ["user_id"], name: "index_upyun_images_on_user_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.integer "sign_in_count", default: 0
    t.datetime "current_sign_in_at", precision: nil
    t.datetime "last_sign_in_at", precision: nil
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.string "nickname"
    t.string "avatar"
    t.string "role"
    t.boolean "blocked", default: false
    t.integer "reward", default: 0
    t.integer "continuous_checkins", default: 0
    t.integer "checkins_count", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["nickname"], name: "index_users_on_nickname", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role"], name: "index_users_on_role"
  end

  add_foreign_key "checkins", "users"
end
