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

ActiveRecord::Schema.define(version: 20160530142001) do

  create_table "categories", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "channels", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "collections", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "companies", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "config_emails", force: true do |t|
    t.string   "server_email"
    t.string   "username"
    t.string   "password_encrypted"
    t.integer  "vendor_id"
    t.boolean  "status",             default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "port"
    t.string   "smtp_server"
  end

  add_index "config_emails", ["vendor_id"], name: "index_config_emails_on_vendor_id"

  create_table "customers", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "customers", ["email"], name: "index_customers_on_email", unique: true
  add_index "customers", ["reset_password_token"], name: "index_customers_on_reset_password_token", unique: true

  create_table "inquiries", force: true do |t|
    t.string   "topic"
    t.string   "first_name"
    t.string   "last_name"
    t.text     "message"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "message_attachments", force: true do |t|
    t.integer  "message_id"
    t.string   "file"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", force: true do |t|
    t.text     "subject"
    t.text     "body"
    t.string   "to"
    t.string   "from"
    t.integer  "status"
    t.date     "date"
    t.integer  "config_email_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "file"
    t.string   "message_id"
    t.boolean  "trash",           default: false
  end

  add_index "messages", ["config_email_id"], name: "index_messages_on_config_email_id"

  create_table "option_images", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "option_value_id"
  end

  add_index "option_images", ["option_value_id"], name: "index_option_images_on_option_value_id"

  create_table "option_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "variant_id"
  end

  add_index "option_types", ["variant_id"], name: "index_option_types_on_variant_id"

  create_table "option_values", force: true do |t|
    t.string   "name"
    t.integer  "option_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "option_values", ["option_type_id"], name: "index_option_values_on_option_type_id"

  create_table "product_collections", force: true do |t|
    t.integer  "product_id"
    t.integer  "collection_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "product_collections", ["collection_id"], name: "index_product_collections_on_collection_id"
  add_index "product_collections", ["product_id"], name: "index_product_collections_on_product_id"

  create_table "product_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "products", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "slug"
    t.text     "meta_description"
    t.string   "meta_keywords"
    t.datetime "publish_date"
    t.integer  "vendor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "products", ["vendor_id"], name: "index_products_on_vendor_id"

  create_table "read_marks", force: true do |t|
    t.integer  "readable_id"
    t.string   "readable_type", null: false
    t.integer  "reader_id"
    t.string   "reader_type",   null: false
    t.datetime "timestamp"
  end

  add_index "read_marks", ["reader_id", "reader_type", "readable_type", "readable_id"], name: "read_marks_reader_readable_index"

  create_table "variants", force: true do |t|
    t.string   "sku"
    t.string   "barcode"
    t.float    "weight"
    t.string   "weight_unit"
    t.float    "price"
    t.float    "compare_price"
    t.boolean  "is_master",     default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "product_id"
  end

  add_index "variants", ["product_id"], name: "index_variants_on_product_id"

  create_table "vendor_categories", force: true do |t|
    t.integer  "vendor_id"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vendor_channels", force: true do |t|
    t.integer  "vendor_id"
    t.integer  "channel_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vendor_companies", force: true do |t|
    t.integer  "vendor_id"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vendors", force: true do |t|
    t.string   "email",                     default: "",    null: false
    t.string   "encrypted_password",        default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",             default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.boolean  "admin",                     default: false
    t.string   "vendor_name"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone_number"
    t.string   "country"
    t.string   "state"
    t.string   "city"
    t.string   "zipcode"
    t.string   "web_site_url"
    t.text     "additional_information"
    t.boolean  "terms_and_condition",       default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "business_address"
    t.string   "sample_photo_file_name"
    t.string   "sample_photo_content_type"
    t.integer  "sample_photo_file_size"
    t.datetime "sample_photo_updated_at"
  end

  add_index "vendors", ["confirmation_token"], name: "index_vendors_on_confirmation_token", unique: true
  add_index "vendors", ["email"], name: "index_vendors_on_email", unique: true
  add_index "vendors", ["reset_password_token"], name: "index_vendors_on_reset_password_token", unique: true

end
