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

ActiveRecord::Schema.define(:version => 20131126164801) do

  create_table "assets", :force => true do |t|
    t.integer  "page_id"
    t.integer  "user_id"
    t.datetime "date_uploaded"
    t.string   "name"
    t.string   "filename"
    t.string   "description"
    t.string   "extension"
  end

  create_table "bookmarks", :force => true do |t|
    t.integer  "law_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "law_categories", :force => true do |t|
    t.string "title"
    t.string "subtitle"
  end

  create_table "laws", :force => true do |t|
    t.string  "legal_id"
    t.string  "title"
    t.text    "content"
    t.integer "law_category_id"
    t.integer "position"
  end

  create_table "page_permissions", :force => true do |t|
    t.integer "role_id"
    t.integer "page_id"
    t.string  "action"
  end

  create_table "pages", :force => true do |t|
    t.integer "parent_id"
    t.string  "title"
    t.string  "menu_title"
    t.text    "content"
    t.string  "slug"
    t.string  "alias"
    t.string  "uri"
    t.string  "redirect_url"
    t.boolean "hide",                                :default => false
    t.integer "content_format",                      :default => 1
    t.text    "custom_css"
    t.text    "custom_js"
    t.text    "linked_resources"
    t.string  "layout"
    t.integer "sort_order",                          :default => 0
    t.boolean "custom_sort_children",                :default => false
    t.string  "seo_title",            :limit => 70
    t.string  "meta_description",     :limit => 156
    t.string  "meta_robots",                         :default => "index, follow"
    t.string  "canonical_url"
    t.string  "fb_description",       :limit => 156
    t.string  "gp_description",       :limit => 156
  end

  create_table "permissions", :force => true do |t|
    t.string "resource"
    t.string "action"
  end

  create_table "permissions_roles", :force => true do |t|
    t.integer "role_id"
    t.integer "permission_id"
  end

  add_index "permissions_roles", ["permission_id"], :name => "index_permissions_roles_on_permission_id"
  add_index "permissions_roles", ["role_id"], :name => "index_permissions_roles_on_role_id"

  create_table "post_categories", :force => true do |t|
    t.string "name"
  end

  create_table "post_category_memberships", :force => true do |t|
    t.integer "post_id"
    t.integer "post_category_id"
  end

  add_index "post_category_memberships", ["post_category_id"], :name => "index_post_category_memberships_on_post_category_id"
  add_index "post_category_memberships", ["post_id"], :name => "index_post_category_memberships_on_post_id"

  create_table "posts", :force => true do |t|
    t.text     "title"
    t.text     "body"
    t.boolean  "hide"
    t.text     "image_url"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "role_memberships", :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  add_index "role_memberships", ["role_id"], :name => "index_role_memberships_on_role_id"
  add_index "role_memberships", ["user_id"], :name => "index_role_memberships_on_user_id"

  create_table "role_permissions", :force => true do |t|
    t.integer "role_id"
    t.integer "permission_id"
  end

  add_index "role_permissions", ["permission_id"], :name => "index_role_permissions_on_permission_id"
  add_index "role_permissions", ["role_id"], :name => "index_role_permissions_on_role_id"

  create_table "roles", :force => true do |t|
    t.integer "parent_id"
    t.string  "name"
    t.string  "description"
  end

  create_table "roles_users", :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  add_index "roles_users", ["role_id"], :name => "index_roles_users_on_role_id"
  add_index "roles_users", ["user_id"], :name => "index_roles_users_on_user_id"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "settings", :force => true do |t|
    t.string "name"
    t.text   "value"
  end

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "username"
    t.string   "email"
    t.string   "phone"
    t.string   "password"
    t.string   "password_reset_id"
    t.datetime "password_reset_sent"
    t.string   "token"
    t.datetime "date_created"
  end

end
