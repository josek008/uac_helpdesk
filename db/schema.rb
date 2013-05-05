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

ActiveRecord::Schema.define(:version => 20130505060549) do

  create_table "assignments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "ticket_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "assignments", ["user_id", "ticket_id"], :name => "index_assignments_on_user_id_and_ticket_id"

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "categories", ["id", "parent_id"], :name => "index_categories_on_id_and_parent_id"
  add_index "categories", ["name"], :name => "index_categories_on_name", :unique => true

  create_table "departments", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "departments", ["name"], :name => "index_departments_on_name", :unique => true

  create_table "logs", :force => true do |t|
    t.integer  "user_id"
    t.integer  "ticket_id"
    t.string   "event"
    t.string   "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "scores", :force => true do |t|
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "scores", ["description"], :name => "index_scores_on_description", :unique => true

  create_table "surveys", :force => true do |t|
    t.integer  "ticket_id"
    t.integer  "tech_id"
    t.integer  "user_id"
    t.integer  "score_id"
    t.string   "state"
    t.string   "comments"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "surveys", ["ticket_id", "tech_id"], :name => "index_surveys_on_ticket_id_and_tech_id"
  add_index "surveys", ["ticket_id"], :name => "index_surveys_on_ticket_id", :unique => true

  create_table "ticket_types", :force => true do |t|
    t.string   "type_descr"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "ticket_types", ["type_descr"], :name => "index_ticket_types_on_type_descr", :unique => true

  create_table "tickets", :force => true do |t|
    t.string   "description"
    t.string   "state"
    t.string   "closing_token"
    t.datetime "resolution_date"
    t.datetime "closed_date"
    t.integer  "user_id"
    t.integer  "ticket_type_id"
    t.integer  "category_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "tickets", ["closing_token"], :name => "index_tickets_on_closing_token", :unique => true
  add_index "tickets", ["state"], :name => "index_tickets_on_state"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "tech",            :default => false
    t.boolean  "admin",           :default => false
    t.integer  "department_id"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token", :unique => true

end
