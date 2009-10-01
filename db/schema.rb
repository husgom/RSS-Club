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

ActiveRecord::Schema.define(:version => 20090926211057) do

  create_table "base_types", :force => true do |t|
    t.string   "name",       :limit => 64
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.integer  "status_id"
    t.string   "name_in_demand", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "demand_offers", :force => true do |t|
    t.integer  "demand_id"
    t.integer  "offer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "demand_section_infos", :force => true do |t|
    t.integer  "demand_section_id"
    t.string   "name",              :limit => 256
    t.integer  "info_type_id"
    t.string   "value",             :limit => 256
    t.integer  "numeric_value"
    t.integer  "sequence"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "demand_sections", :force => true do |t|
    t.integer  "demand_id"
    t.integer  "section_type_id"
    t.string   "name",            :limit => 256
    t.integer  "sequence"
    t.boolean  "onleft"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "demand_types", :force => true do |t|
    t.string   "name",          :limit => 256
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "offer_type_id", :limit => 8,   :null => false
  end

  create_table "demand_types_section_types", :id => false, :force => true do |t|
    t.integer  "demand_type_id",  :null => false
    t.integer  "section_type_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "demands", :force => true do |t|
    t.string   "name",               :limit => 256
    t.text     "notes",                                            :null => false
    t.integer  "max_price_in_cents",                :default => 0, :null => false
    t.integer  "min_price_in_cents",                :default => 0, :null => false
    t.integer  "max_offer_id",       :limit => 8
    t.integer  "min_offer_id",       :limit => 8
    t.integer  "demand_type_id",                    :default => 1
    t.integer  "user_id",            :limit => 8,                  :null => false
    t.integer  "status_id",          :limit => 8,                  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "email_request_hists", :force => true do |t|
    t.string   "code"
    t.string   "action"
    t.integer  "status_id"
    t.integer  "record_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "email_requests", :force => true do |t|
    t.string   "code"
    t.string   "action"
    t.integer  "record_id"
    t.integer  "status_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "info_types", :force => true do |t|
    t.string   "name",         :limit => 256
    t.string   "desc",         :limit => 256
    t.integer  "base_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "offer_infos", :force => true do |t|
    t.integer  "offer_id"
    t.integer  "info_type_id"
    t.string   "value"
    t.integer  "numeric_value"
    t.integer  "sequence"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "offers", :force => true do |t|
    t.integer  "demand_id",      :limit => 8,                :null => false
    t.integer  "user_id",        :limit => 8,                :null => false
    t.integer  "status_id",      :limit => 8, :default => 5, :null => false
    t.integer  "price_in_cents"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "section_type_infos", :force => true do |t|
    t.integer  "sequence",        :default => 0, :null => false
    t.integer  "info_type_id"
    t.integer  "section_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "section_types", :force => true do |t|
    t.string   "name",       :limit => 256
    t.string   "desc",                                         :null => false
    t.integer  "sequence"
    t.boolean  "onleft",                    :default => false
    t.string   "owner",      :limit => 256
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "statuses", :force => true do |t|
    t.string   "name"
    t.string   "category"
    t.integer  "sequence",   :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string  "name"
    t.string  "contact_name",                                    :null => false
    t.string  "company_name",                                    :null => false
    t.string  "email",                                           :null => false
    t.integer "company_id",      :limit => 8,                    :null => false
    t.string  "hashed_password"
    t.string  "salt"
    t.boolean "admin",                                           :null => false
    t.boolean "company_admin",                :default => false, :null => false
    t.integer "user_type_id",    :limit => 8,                    :null => false
    t.integer "status_id",       :limit => 8,                    :null => false
  end

end
