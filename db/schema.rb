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

ActiveRecord::Schema.define(version: 20160805081502) do

  create_table "accounts", force: :cascade do |t|
    t.string   "name"
    t.integer  "vendor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "category_forms", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "channel_forms", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "channels", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "collections", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "companies", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "config_emails", force: :cascade do |t|
    t.string   "server_email"
    t.string   "username"
    t.string   "password_encrypted"
    t.integer  "vendor_id"
    t.boolean  "status",             default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "port"
    t.string   "smtp_server"
    t.string   "server_name"
  end

  add_index "config_emails", ["vendor_id"], name: "index_config_emails_on_vendor_id"

  create_table "customers", force: :cascade do |t|
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

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
    t.datetime "deleted_at"
  end

  add_index "friendly_id_slugs", ["deleted_at"], name: "index_friendly_id_slugs_on_deleted_at"
  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"

  create_table "inquiries", force: :cascade do |t|
    t.string   "topic"
    t.string   "first_name"
    t.string   "last_name"
    t.text     "message"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", force: :cascade do |t|
    t.string   "ip"
    t.string   "country_name"
    t.string   "country_code"
    t.string   "region_code"
    t.string   "region_name"
    t.string   "city"
    t.string   "zipcode"
    t.string   "time_zone"
    t.string   "latitude"
    t.string   "longitude"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "message_attachments", force: :cascade do |t|
    t.integer  "message_id"
    t.string   "file"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", force: :cascade do |t|
    t.text     "subject"
    t.text     "body"
    t.string   "to"
    t.string   "from"
    t.integer  "status"
    t.datetime "date",                            null: false
    t.integer  "config_email_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "file"
    t.string   "message_id"
    t.boolean  "trash",           default: false
    t.boolean  "starred",         default: false
    t.boolean  "important",       default: false
  end

  add_index "messages", ["config_email_id"], name: "index_messages_on_config_email_id"

  create_table "onboarding_brands", force: :cascade do |t|
    t.string   "name"
    t.integer  "vendor_onboarding_form_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "onboarding_brands", ["vendor_onboarding_form_id"], name: "index_onboarding_brands_on_vendor_onboarding_form_id"

  create_table "onboarding_carriers", force: :cascade do |t|
    t.string   "name"
    t.integer  "vendor_onboarding_form_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "onboarding_carriers", ["vendor_onboarding_form_id"], name: "index_onboarding_carriers_on_vendor_onboarding_form_id"

  create_table "onboarding_product_types", force: :cascade do |t|
    t.string   "name"
    t.integer  "vendor_onboarding_form_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "onboarding_product_types", ["vendor_onboarding_form_id"], name: "index_onboarding_product_types_on_vendor_onboarding_form_id"

  create_table "onboarding_transportations", force: :cascade do |t|
    t.string   "ship_from_information_street"
    t.string   "ship_from_information_unit"
    t.string   "ship_from_information_city"
    t.string   "ship_from_information_state"
    t.string   "ship_from_information_zip"
    t.string   "ship_from_information_country"
    t.string   "transportation_contact_name"
    t.string   "transportation_contact_phone"
    t.string   "transportation_contact_email"
    t.string   "transportation_contact_fax"
    t.integer  "vendor_onboarding_form_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "onboarding_transportations", ["vendor_onboarding_form_id"], name: "index_onboarding_transportations_on_vendor_onboarding_form_id"

  create_table "option_forms", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "option_images", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "option_value_id"
  end

  add_index "option_images", ["option_value_id"], name: "index_option_images_on_option_value_id"

  create_table "option_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "variant_id"
  end

  add_index "option_types", ["variant_id"], name: "index_option_types_on_variant_id"

  create_table "option_values", force: :cascade do |t|
    t.string   "name"
    t.integer  "option_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "option_values", ["option_type_id"], name: "index_option_values_on_option_type_id"

  create_table "permissions", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.string   "key"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_collections", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "collection_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "product_collections", ["collection_id"], name: "index_product_collections_on_collection_id"
  add_index "product_collections", ["product_id"], name: "index_product_collections_on_product_id"

  create_table "product_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "products", force: :cascade do |t|
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

  create_table "read_marks", force: :cascade do |t|
    t.integer  "readable_id"
    t.string   "readable_type", null: false
    t.integer  "reader_id"
    t.string   "reader_type",   null: false
    t.datetime "timestamp"
  end

  add_index "read_marks", ["reader_id", "reader_type", "readable_type", "readable_id"], name: "read_marks_reader_readable_index"

  create_table "role_permissions", force: :cascade do |t|
    t.integer  "role_id"
    t.integer  "permission_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "vendor_id"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], name: "index_roles_on_name"

  create_table "spree_addresses", force: :cascade do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "zipcode"
    t.string   "phone"
    t.string   "state_name"
    t.string   "alternative_phone"
    t.string   "company"
    t.integer  "state_id"
    t.integer  "country_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "spree_addresses", ["country_id"], name: "index_spree_addresses_on_country_id"
  add_index "spree_addresses", ["firstname"], name: "index_addresses_on_firstname"
  add_index "spree_addresses", ["lastname"], name: "index_addresses_on_lastname"
  add_index "spree_addresses", ["state_id"], name: "index_spree_addresses_on_state_id"

  create_table "spree_adjustments", force: :cascade do |t|
    t.integer  "source_id"
    t.string   "source_type"
    t.integer  "adjustable_id"
    t.string   "adjustable_type"
    t.decimal  "amount",          precision: 10, scale: 2
    t.string   "label"
    t.boolean  "mandatory"
    t.boolean  "eligible",                                 default: true
    t.datetime "created_at",                                               null: false
    t.datetime "updated_at",                                               null: false
    t.string   "state"
    t.integer  "order_id",                                                 null: false
    t.boolean  "included",                                 default: false
  end

  add_index "spree_adjustments", ["adjustable_id", "adjustable_type"], name: "index_spree_adjustments_on_adjustable_id_and_adjustable_type"
  add_index "spree_adjustments", ["eligible"], name: "index_spree_adjustments_on_eligible"
  add_index "spree_adjustments", ["order_id"], name: "index_spree_adjustments_on_order_id"
  add_index "spree_adjustments", ["source_id", "source_type"], name: "index_spree_adjustments_on_source_id_and_source_type"

  create_table "spree_assets", force: :cascade do |t|
    t.integer  "viewable_id"
    t.string   "viewable_type"
    t.integer  "attachment_width"
    t.integer  "attachment_height"
    t.integer  "attachment_file_size"
    t.integer  "position"
    t.string   "attachment_content_type"
    t.string   "attachment_file_name"
    t.string   "type",                    limit: 75
    t.datetime "attachment_updated_at"
    t.text     "alt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "spree_assets", ["position"], name: "index_spree_assets_on_position"
  add_index "spree_assets", ["viewable_id"], name: "index_assets_on_viewable_id"
  add_index "spree_assets", ["viewable_type", "type"], name: "index_assets_on_viewable_type_and_type"

  create_table "spree_calculators", force: :cascade do |t|
    t.string   "type"
    t.integer  "calculable_id"
    t.string   "calculable_type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.text     "preferences"
    t.datetime "deleted_at"
  end

  add_index "spree_calculators", ["calculable_id", "calculable_type"], name: "index_spree_calculators_on_calculable_id_and_calculable_type"
  add_index "spree_calculators", ["deleted_at"], name: "index_spree_calculators_on_deleted_at"
  add_index "spree_calculators", ["id", "type"], name: "index_spree_calculators_on_id_and_type"

  create_table "spree_countries", force: :cascade do |t|
    t.string   "iso_name"
    t.string   "iso"
    t.string   "iso3"
    t.string   "name"
    t.integer  "numcode"
    t.boolean  "states_required",  default: false
    t.datetime "updated_at"
    t.boolean  "zipcode_required", default: true
  end

  create_table "spree_credit_cards", force: :cascade do |t|
    t.string   "month"
    t.string   "year"
    t.string   "cc_type"
    t.string   "last_digits"
    t.integer  "address_id"
    t.string   "gateway_customer_profile_id"
    t.string   "gateway_payment_profile_id"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.string   "name"
    t.integer  "user_id"
    t.integer  "payment_method_id"
    t.boolean  "default",                     default: false, null: false
  end

  add_index "spree_credit_cards", ["address_id"], name: "index_spree_credit_cards_on_address_id"
  add_index "spree_credit_cards", ["payment_method_id"], name: "index_spree_credit_cards_on_payment_method_id"
  add_index "spree_credit_cards", ["user_id"], name: "index_spree_credit_cards_on_user_id"

  create_table "spree_customer_returns", force: :cascade do |t|
    t.string   "number"
    t.integer  "stock_location_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "spree_gateways", force: :cascade do |t|
    t.string   "type"
    t.string   "name"
    t.text     "description"
    t.boolean  "active",      default: true
    t.string   "environment", default: "development"
    t.string   "server",      default: "test"
    t.boolean  "test_mode",   default: true
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.text     "preferences"
  end

  add_index "spree_gateways", ["active"], name: "index_spree_gateways_on_active"
  add_index "spree_gateways", ["test_mode"], name: "index_spree_gateways_on_test_mode"

  create_table "spree_inventory_units", force: :cascade do |t|
    t.string   "state"
    t.integer  "variant_id"
    t.integer  "order_id"
    t.integer  "shipment_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.boolean  "pending",      default: true
    t.integer  "line_item_id"
  end

  add_index "spree_inventory_units", ["line_item_id"], name: "index_spree_inventory_units_on_line_item_id"
  add_index "spree_inventory_units", ["order_id"], name: "index_inventory_units_on_order_id"
  add_index "spree_inventory_units", ["shipment_id"], name: "index_inventory_units_on_shipment_id"
  add_index "spree_inventory_units", ["variant_id"], name: "index_inventory_units_on_variant_id"

  create_table "spree_line_items", force: :cascade do |t|
    t.integer  "variant_id"
    t.integer  "order_id"
    t.integer  "quantity",                                                            null: false
    t.decimal  "price",                        precision: 10, scale: 2,               null: false
    t.datetime "created_at",                                                          null: false
    t.datetime "updated_at",                                                          null: false
    t.string   "currency"
    t.decimal  "cost_price",                   precision: 10, scale: 2
    t.integer  "tax_category_id"
    t.decimal  "adjustment_total",             precision: 10, scale: 2, default: 0.0
    t.decimal  "additional_tax_total",         precision: 10, scale: 2, default: 0.0
    t.decimal  "promo_total",                  precision: 10, scale: 2, default: 0.0
    t.decimal  "included_tax_total",           precision: 10, scale: 2, default: 0.0, null: false
    t.decimal  "pre_tax_amount",               precision: 12, scale: 4, default: 0.0, null: false
    t.decimal  "taxable_adjustment_total",     precision: 10, scale: 2, default: 0.0, null: false
    t.decimal  "non_taxable_adjustment_total", precision: 10, scale: 2, default: 0.0, null: false
  end

  add_index "spree_line_items", ["order_id"], name: "index_spree_line_items_on_order_id"
  add_index "spree_line_items", ["tax_category_id"], name: "index_spree_line_items_on_tax_category_id"
  add_index "spree_line_items", ["variant_id"], name: "index_spree_line_items_on_variant_id"

  create_table "spree_log_entries", force: :cascade do |t|
    t.integer  "source_id"
    t.string   "source_type"
    t.text     "details"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "spree_log_entries", ["source_id", "source_type"], name: "index_spree_log_entries_on_source_id_and_source_type"

  create_table "spree_option_type_prototypes", force: :cascade do |t|
    t.integer "prototype_id"
    t.integer "option_type_id"
  end

  add_index "spree_option_type_prototypes", ["option_type_id"], name: "index_spree_option_type_prototypes_on_option_type_id"
  add_index "spree_option_type_prototypes", ["prototype_id", "option_type_id"], name: "index_option_types_prototypes_on_prototype_and_option_type"

  create_table "spree_option_types", force: :cascade do |t|
    t.string   "name",         limit: 100
    t.string   "presentation", limit: 100
    t.integer  "position",                 default: 0, null: false
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  add_index "spree_option_types", ["name"], name: "index_spree_option_types_on_name"
  add_index "spree_option_types", ["position"], name: "index_spree_option_types_on_position"

  create_table "spree_option_value_variants", force: :cascade do |t|
    t.integer "variant_id"
    t.integer "option_value_id"
  end

  add_index "spree_option_value_variants", ["option_value_id"], name: "index_spree_option_value_variants_on_option_value_id"
  add_index "spree_option_value_variants", ["variant_id", "option_value_id"], name: "index_option_values_variants_on_variant_id_and_option_value_id"

  create_table "spree_option_values", force: :cascade do |t|
    t.integer  "position"
    t.string   "name"
    t.string   "presentation"
    t.integer  "option_type_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "spree_option_values", ["name"], name: "index_spree_option_values_on_name"
  add_index "spree_option_values", ["option_type_id"], name: "index_spree_option_values_on_option_type_id"
  add_index "spree_option_values", ["position"], name: "index_spree_option_values_on_position"

  create_table "spree_order_promotions", force: :cascade do |t|
    t.integer "order_id"
    t.integer "promotion_id"
  end

  add_index "spree_order_promotions", ["order_id"], name: "index_spree_order_promotions_on_order_id"
  add_index "spree_order_promotions", ["promotion_id", "order_id"], name: "index_spree_order_promotions_on_promotion_id_and_order_id"

  create_table "spree_orders", force: :cascade do |t|
    t.string   "number",                       limit: 32
    t.decimal  "item_total",                              precision: 10, scale: 2, default: 0.0,     null: false
    t.decimal  "total",                                   precision: 10, scale: 2, default: 0.0,     null: false
    t.string   "state"
    t.decimal  "adjustment_total",                        precision: 10, scale: 2, default: 0.0,     null: false
    t.integer  "user_id"
    t.datetime "completed_at"
    t.integer  "bill_address_id"
    t.integer  "ship_address_id"
    t.decimal  "payment_total",                           precision: 10, scale: 2, default: 0.0
    t.string   "shipment_state"
    t.string   "payment_state"
    t.string   "email"
    t.text     "special_instructions"
    t.datetime "created_at",                                                                         null: false
    t.datetime "updated_at",                                                                         null: false
    t.string   "currency"
    t.string   "last_ip_address"
    t.integer  "created_by_id"
    t.decimal  "shipment_total",                          precision: 10, scale: 2, default: 0.0,     null: false
    t.decimal  "additional_tax_total",                    precision: 10, scale: 2, default: 0.0
    t.decimal  "promo_total",                             precision: 10, scale: 2, default: 0.0
    t.string   "channel",                                                          default: "spree"
    t.decimal  "included_tax_total",                      precision: 10, scale: 2, default: 0.0,     null: false
    t.integer  "item_count",                                                       default: 0
    t.integer  "approver_id"
    t.datetime "approved_at"
    t.boolean  "confirmation_delivered",                                           default: false
    t.boolean  "considered_risky",                                                 default: false
    t.string   "guest_token"
    t.datetime "canceled_at"
    t.integer  "canceler_id"
    t.integer  "store_id"
    t.integer  "state_lock_version",                                               default: 0,       null: false
    t.decimal  "taxable_adjustment_total",                precision: 10, scale: 2, default: 0.0,     null: false
    t.decimal  "non_taxable_adjustment_total",            precision: 10, scale: 2, default: 0.0,     null: false
  end

  add_index "spree_orders", ["approver_id"], name: "index_spree_orders_on_approver_id"
  add_index "spree_orders", ["bill_address_id"], name: "index_spree_orders_on_bill_address_id"
  add_index "spree_orders", ["canceler_id"], name: "index_spree_orders_on_canceler_id"
  add_index "spree_orders", ["completed_at"], name: "index_spree_orders_on_completed_at"
  add_index "spree_orders", ["confirmation_delivered"], name: "index_spree_orders_on_confirmation_delivered"
  add_index "spree_orders", ["considered_risky"], name: "index_spree_orders_on_considered_risky"
  add_index "spree_orders", ["created_by_id"], name: "index_spree_orders_on_created_by_id"
  add_index "spree_orders", ["guest_token"], name: "index_spree_orders_on_guest_token"
  add_index "spree_orders", ["number"], name: "index_spree_orders_on_number"
  add_index "spree_orders", ["ship_address_id"], name: "index_spree_orders_on_ship_address_id"
  add_index "spree_orders", ["store_id"], name: "index_spree_orders_on_store_id"
  add_index "spree_orders", ["user_id", "created_by_id"], name: "index_spree_orders_on_user_id_and_created_by_id"

  create_table "spree_payment_capture_events", force: :cascade do |t|
    t.decimal  "amount",     precision: 10, scale: 2, default: 0.0
    t.integer  "payment_id"
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
  end

  add_index "spree_payment_capture_events", ["payment_id"], name: "index_spree_payment_capture_events_on_payment_id"

  create_table "spree_payment_methods", force: :cascade do |t|
    t.string   "type"
    t.string   "name"
    t.text     "description"
    t.boolean  "active",       default: true
    t.datetime "deleted_at"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "display_on",   default: "both"
    t.boolean  "auto_capture"
    t.text     "preferences"
    t.integer  "position",     default: 0
  end

  add_index "spree_payment_methods", ["id", "type"], name: "index_spree_payment_methods_on_id_and_type"

  create_table "spree_payments", force: :cascade do |t|
    t.decimal  "amount",               precision: 10, scale: 2, default: 0.0, null: false
    t.integer  "order_id"
    t.integer  "source_id"
    t.string   "source_type"
    t.integer  "payment_method_id"
    t.string   "state"
    t.string   "response_code"
    t.string   "avs_response"
    t.datetime "created_at",                                                  null: false
    t.datetime "updated_at",                                                  null: false
    t.string   "number"
    t.string   "cvv_response_code"
    t.string   "cvv_response_message"
  end

  add_index "spree_payments", ["number"], name: "index_spree_payments_on_number"
  add_index "spree_payments", ["order_id"], name: "index_spree_payments_on_order_id"
  add_index "spree_payments", ["payment_method_id"], name: "index_spree_payments_on_payment_method_id"
  add_index "spree_payments", ["source_id", "source_type"], name: "index_spree_payments_on_source_id_and_source_type"

  create_table "spree_preferences", force: :cascade do |t|
    t.text     "value"
    t.string   "key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "spree_preferences", ["key"], name: "index_spree_preferences_on_key", unique: true

  create_table "spree_prices", force: :cascade do |t|
    t.integer  "variant_id",                          null: false
    t.decimal  "amount",     precision: 10, scale: 2
    t.string   "currency"
    t.datetime "deleted_at"
  end

  add_index "spree_prices", ["deleted_at"], name: "index_spree_prices_on_deleted_at"
  add_index "spree_prices", ["variant_id", "currency"], name: "index_spree_prices_on_variant_id_and_currency"
  add_index "spree_prices", ["variant_id"], name: "index_spree_prices_on_variant_id"

  create_table "spree_product_option_types", force: :cascade do |t|
    t.integer  "position"
    t.integer  "product_id"
    t.integer  "option_type_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "spree_product_option_types", ["option_type_id"], name: "index_spree_product_option_types_on_option_type_id"
  add_index "spree_product_option_types", ["position"], name: "index_spree_product_option_types_on_position"
  add_index "spree_product_option_types", ["product_id"], name: "index_spree_product_option_types_on_product_id"

  create_table "spree_product_promotion_rules", force: :cascade do |t|
    t.integer "product_id"
    t.integer "promotion_rule_id"
  end

  add_index "spree_product_promotion_rules", ["product_id"], name: "index_products_promotion_rules_on_product_id"
  add_index "spree_product_promotion_rules", ["promotion_rule_id", "product_id"], name: "index_products_promotion_rules_on_promotion_rule_and_product"

  create_table "spree_product_properties", force: :cascade do |t|
    t.string   "value"
    t.integer  "product_id"
    t.integer  "property_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "position",    default: 0
  end

  add_index "spree_product_properties", ["position"], name: "index_spree_product_properties_on_position"
  add_index "spree_product_properties", ["product_id"], name: "index_product_properties_on_product_id"
  add_index "spree_product_properties", ["property_id"], name: "index_spree_product_properties_on_property_id"

  create_table "spree_products", force: :cascade do |t|
    t.string   "name",                 default: "",   null: false
    t.text     "description"
    t.datetime "available_on"
    t.datetime "deleted_at"
    t.string   "slug"
    t.text     "meta_description"
    t.string   "meta_keywords"
    t.integer  "tax_category_id"
    t.integer  "shipping_category_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.boolean  "promotionable",        default: true
    t.string   "meta_title"
    t.datetime "discontinue_on"
  end

  add_index "spree_products", ["available_on"], name: "index_spree_products_on_available_on"
  add_index "spree_products", ["deleted_at"], name: "index_spree_products_on_deleted_at"
  add_index "spree_products", ["discontinue_on"], name: "index_spree_products_on_discontinue_on"
  add_index "spree_products", ["name"], name: "index_spree_products_on_name"
  add_index "spree_products", ["shipping_category_id"], name: "index_spree_products_on_shipping_category_id"
  add_index "spree_products", ["slug"], name: "index_spree_products_on_slug", unique: true
  add_index "spree_products", ["tax_category_id"], name: "index_spree_products_on_tax_category_id"

  create_table "spree_products_taxons", force: :cascade do |t|
    t.integer "product_id"
    t.integer "taxon_id"
    t.integer "position"
  end

  add_index "spree_products_taxons", ["position"], name: "index_spree_products_taxons_on_position"
  add_index "spree_products_taxons", ["product_id"], name: "index_spree_products_taxons_on_product_id"
  add_index "spree_products_taxons", ["taxon_id"], name: "index_spree_products_taxons_on_taxon_id"

  create_table "spree_promotion_action_line_items", force: :cascade do |t|
    t.integer "promotion_action_id"
    t.integer "variant_id"
    t.integer "quantity",            default: 1
  end

  add_index "spree_promotion_action_line_items", ["promotion_action_id"], name: "index_spree_promotion_action_line_items_on_promotion_action_id"
  add_index "spree_promotion_action_line_items", ["variant_id"], name: "index_spree_promotion_action_line_items_on_variant_id"

  create_table "spree_promotion_actions", force: :cascade do |t|
    t.integer  "promotion_id"
    t.integer  "position"
    t.string   "type"
    t.datetime "deleted_at"
  end

  add_index "spree_promotion_actions", ["deleted_at"], name: "index_spree_promotion_actions_on_deleted_at"
  add_index "spree_promotion_actions", ["id", "type"], name: "index_spree_promotion_actions_on_id_and_type"
  add_index "spree_promotion_actions", ["promotion_id"], name: "index_spree_promotion_actions_on_promotion_id"

  create_table "spree_promotion_categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "code"
  end

  create_table "spree_promotion_rule_taxons", force: :cascade do |t|
    t.integer "taxon_id"
    t.integer "promotion_rule_id"
  end

  add_index "spree_promotion_rule_taxons", ["promotion_rule_id"], name: "index_spree_promotion_rule_taxons_on_promotion_rule_id"
  add_index "spree_promotion_rule_taxons", ["taxon_id"], name: "index_spree_promotion_rule_taxons_on_taxon_id"

  create_table "spree_promotion_rule_users", force: :cascade do |t|
    t.integer "user_id"
    t.integer "promotion_rule_id"
  end

  add_index "spree_promotion_rule_users", ["promotion_rule_id"], name: "index_promotion_rules_users_on_promotion_rule_id"
  add_index "spree_promotion_rule_users", ["user_id", "promotion_rule_id"], name: "index_promotion_rules_users_on_user_id_and_promotion_rule_id"

  create_table "spree_promotion_rules", force: :cascade do |t|
    t.integer  "promotion_id"
    t.integer  "user_id"
    t.integer  "product_group_id"
    t.string   "type"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "code"
    t.text     "preferences"
  end

  add_index "spree_promotion_rules", ["product_group_id"], name: "index_promotion_rules_on_product_group_id"
  add_index "spree_promotion_rules", ["promotion_id"], name: "index_spree_promotion_rules_on_promotion_id"
  add_index "spree_promotion_rules", ["user_id"], name: "index_promotion_rules_on_user_id"

  create_table "spree_promotions", force: :cascade do |t|
    t.string   "description"
    t.datetime "expires_at"
    t.datetime "starts_at"
    t.string   "name"
    t.string   "type"
    t.integer  "usage_limit"
    t.string   "match_policy",          default: "all"
    t.string   "code"
    t.boolean  "advertise",             default: false
    t.string   "path"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "promotion_category_id"
  end

  add_index "spree_promotions", ["advertise"], name: "index_spree_promotions_on_advertise"
  add_index "spree_promotions", ["code"], name: "index_spree_promotions_on_code"
  add_index "spree_promotions", ["expires_at"], name: "index_spree_promotions_on_expires_at"
  add_index "spree_promotions", ["id", "type"], name: "index_spree_promotions_on_id_and_type"
  add_index "spree_promotions", ["promotion_category_id"], name: "index_spree_promotions_on_promotion_category_id"
  add_index "spree_promotions", ["starts_at"], name: "index_spree_promotions_on_starts_at"

  create_table "spree_properties", force: :cascade do |t|
    t.string   "name"
    t.string   "presentation", null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "spree_properties", ["name"], name: "index_spree_properties_on_name"

  create_table "spree_property_prototypes", force: :cascade do |t|
    t.integer "prototype_id"
    t.integer "property_id"
  end

  add_index "spree_property_prototypes", ["prototype_id", "property_id"], name: "index_properties_prototypes_on_prototype_and_property"

  create_table "spree_prototype_taxons", force: :cascade do |t|
    t.integer "taxon_id"
    t.integer "prototype_id"
  end

  add_index "spree_prototype_taxons", ["prototype_id", "taxon_id"], name: "index_spree_prototype_taxons_on_prototype_id_and_taxon_id"
  add_index "spree_prototype_taxons", ["taxon_id"], name: "index_spree_prototype_taxons_on_taxon_id"

  create_table "spree_prototypes", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "spree_refund_reasons", force: :cascade do |t|
    t.string   "name"
    t.boolean  "active",     default: true
    t.boolean  "mutable",    default: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "spree_refunds", force: :cascade do |t|
    t.integer  "payment_id"
    t.decimal  "amount",           precision: 10, scale: 2, default: 0.0, null: false
    t.string   "transaction_id"
    t.datetime "created_at",                                              null: false
    t.datetime "updated_at",                                              null: false
    t.integer  "refund_reason_id"
    t.integer  "reimbursement_id"
  end

  add_index "spree_refunds", ["refund_reason_id"], name: "index_refunds_on_refund_reason_id"

  create_table "spree_reimbursement_credits", force: :cascade do |t|
    t.decimal "amount",           precision: 10, scale: 2, default: 0.0, null: false
    t.integer "reimbursement_id"
    t.integer "creditable_id"
    t.string  "creditable_type"
  end

  create_table "spree_reimbursement_types", force: :cascade do |t|
    t.string   "name"
    t.boolean  "active",     default: true
    t.boolean  "mutable",    default: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "type"
  end

  add_index "spree_reimbursement_types", ["type"], name: "index_spree_reimbursement_types_on_type"

  create_table "spree_reimbursements", force: :cascade do |t|
    t.string   "number"
    t.string   "reimbursement_status"
    t.integer  "customer_return_id"
    t.integer  "order_id"
    t.decimal  "total",                precision: 10, scale: 2
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
  end

  add_index "spree_reimbursements", ["customer_return_id"], name: "index_spree_reimbursements_on_customer_return_id"
  add_index "spree_reimbursements", ["order_id"], name: "index_spree_reimbursements_on_order_id"

  create_table "spree_return_authorization_reasons", force: :cascade do |t|
    t.string   "name"
    t.boolean  "active",     default: true
    t.boolean  "mutable",    default: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "spree_return_authorizations", force: :cascade do |t|
    t.string   "number"
    t.string   "state"
    t.integer  "order_id"
    t.text     "memo"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "stock_location_id"
    t.integer  "return_authorization_reason_id"
  end

  add_index "spree_return_authorizations", ["return_authorization_reason_id"], name: "index_return_authorizations_on_return_authorization_reason_id"

  create_table "spree_return_items", force: :cascade do |t|
    t.integer  "return_authorization_id"
    t.integer  "inventory_unit_id"
    t.integer  "exchange_variant_id"
    t.datetime "created_at",                                                              null: false
    t.datetime "updated_at",                                                              null: false
    t.decimal  "pre_tax_amount",                  precision: 12, scale: 4, default: 0.0,  null: false
    t.decimal  "included_tax_total",              precision: 12, scale: 4, default: 0.0,  null: false
    t.decimal  "additional_tax_total",            precision: 12, scale: 4, default: 0.0,  null: false
    t.string   "reception_status"
    t.string   "acceptance_status"
    t.integer  "customer_return_id"
    t.integer  "reimbursement_id"
    t.integer  "exchange_inventory_unit_id"
    t.text     "acceptance_status_errors"
    t.integer  "preferred_reimbursement_type_id"
    t.integer  "override_reimbursement_type_id"
    t.boolean  "resellable",                                               default: true, null: false
  end

  add_index "spree_return_items", ["customer_return_id"], name: "index_return_items_on_customer_return_id"
  add_index "spree_return_items", ["exchange_inventory_unit_id"], name: "index_spree_return_items_on_exchange_inventory_unit_id"

  create_table "spree_role_users", force: :cascade do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  add_index "spree_role_users", ["role_id"], name: "index_spree_role_users_on_role_id"
  add_index "spree_role_users", ["user_id"], name: "index_spree_role_users_on_user_id"

  create_table "spree_roles", force: :cascade do |t|
    t.string "name"
  end

  add_index "spree_roles", ["name"], name: "index_spree_roles_on_name"

  create_table "spree_shipments", force: :cascade do |t|
    t.string   "tracking"
    t.string   "number"
    t.decimal  "cost",                         precision: 10, scale: 2, default: 0.0
    t.datetime "shipped_at"
    t.integer  "order_id"
    t.integer  "address_id"
    t.string   "state"
    t.datetime "created_at",                                                          null: false
    t.datetime "updated_at",                                                          null: false
    t.integer  "stock_location_id"
    t.decimal  "adjustment_total",             precision: 10, scale: 2, default: 0.0
    t.decimal  "additional_tax_total",         precision: 10, scale: 2, default: 0.0
    t.decimal  "promo_total",                  precision: 10, scale: 2, default: 0.0
    t.decimal  "included_tax_total",           precision: 10, scale: 2, default: 0.0, null: false
    t.decimal  "pre_tax_amount",               precision: 12, scale: 4, default: 0.0, null: false
    t.decimal  "taxable_adjustment_total",     precision: 10, scale: 2, default: 0.0, null: false
    t.decimal  "non_taxable_adjustment_total", precision: 10, scale: 2, default: 0.0, null: false
  end

  add_index "spree_shipments", ["address_id"], name: "index_spree_shipments_on_address_id"
  add_index "spree_shipments", ["number"], name: "index_shipments_on_number"
  add_index "spree_shipments", ["order_id"], name: "index_spree_shipments_on_order_id"
  add_index "spree_shipments", ["stock_location_id"], name: "index_spree_shipments_on_stock_location_id"

  create_table "spree_shipping_categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "spree_shipping_categories", ["name"], name: "index_spree_shipping_categories_on_name"

  create_table "spree_shipping_method_categories", force: :cascade do |t|
    t.integer  "shipping_method_id",   null: false
    t.integer  "shipping_category_id", null: false
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "spree_shipping_method_categories", ["shipping_category_id", "shipping_method_id"], name: "unique_spree_shipping_method_categories", unique: true
  add_index "spree_shipping_method_categories", ["shipping_method_id"], name: "index_spree_shipping_method_categories_on_shipping_method_id"

  create_table "spree_shipping_method_zones", force: :cascade do |t|
    t.integer "shipping_method_id"
    t.integer "zone_id"
  end

  create_table "spree_shipping_methods", force: :cascade do |t|
    t.string   "name"
    t.string   "display_on"
    t.datetime "deleted_at"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "tracking_url"
    t.string   "admin_name"
    t.integer  "tax_category_id"
    t.string   "code"
  end

  add_index "spree_shipping_methods", ["deleted_at"], name: "index_spree_shipping_methods_on_deleted_at"
  add_index "spree_shipping_methods", ["tax_category_id"], name: "index_spree_shipping_methods_on_tax_category_id"

  create_table "spree_shipping_rates", force: :cascade do |t|
    t.integer  "shipment_id"
    t.integer  "shipping_method_id"
    t.boolean  "selected",                                   default: false
    t.decimal  "cost",               precision: 8, scale: 2, default: 0.0
    t.datetime "created_at",                                                 null: false
    t.datetime "updated_at",                                                 null: false
    t.integer  "tax_rate_id"
  end

  add_index "spree_shipping_rates", ["selected"], name: "index_spree_shipping_rates_on_selected"
  add_index "spree_shipping_rates", ["shipment_id", "shipping_method_id"], name: "spree_shipping_rates_join_index", unique: true
  add_index "spree_shipping_rates", ["tax_rate_id"], name: "index_spree_shipping_rates_on_tax_rate_id"

  create_table "spree_state_changes", force: :cascade do |t|
    t.string   "name"
    t.string   "previous_state"
    t.integer  "stateful_id"
    t.integer  "user_id"
    t.string   "stateful_type"
    t.string   "next_state"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "spree_state_changes", ["stateful_id", "stateful_type"], name: "index_spree_state_changes_on_stateful_id_and_stateful_type"

  create_table "spree_states", force: :cascade do |t|
    t.string   "name"
    t.string   "abbr"
    t.integer  "country_id"
    t.datetime "updated_at"
  end

  add_index "spree_states", ["country_id"], name: "index_spree_states_on_country_id"

  create_table "spree_stock_items", force: :cascade do |t|
    t.integer  "stock_location_id"
    t.integer  "variant_id"
    t.integer  "count_on_hand",     default: 0,     null: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.boolean  "backorderable",     default: false
    t.datetime "deleted_at"
  end

  add_index "spree_stock_items", ["backorderable"], name: "index_spree_stock_items_on_backorderable"
  add_index "spree_stock_items", ["deleted_at"], name: "index_spree_stock_items_on_deleted_at"
  add_index "spree_stock_items", ["stock_location_id", "variant_id"], name: "stock_item_by_loc_and_var_id"
  add_index "spree_stock_items", ["variant_id"], name: "index_spree_stock_items_on_variant_id"

  create_table "spree_stock_locations", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "default",                default: false, null: false
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.integer  "state_id"
    t.string   "state_name"
    t.integer  "country_id"
    t.string   "zipcode"
    t.string   "phone"
    t.boolean  "active",                 default: true
    t.boolean  "backorderable_default",  default: false
    t.boolean  "propagate_all_variants", default: true
    t.string   "admin_name"
  end

  add_index "spree_stock_locations", ["active"], name: "index_spree_stock_locations_on_active"
  add_index "spree_stock_locations", ["backorderable_default"], name: "index_spree_stock_locations_on_backorderable_default"
  add_index "spree_stock_locations", ["country_id"], name: "index_spree_stock_locations_on_country_id"
  add_index "spree_stock_locations", ["propagate_all_variants"], name: "index_spree_stock_locations_on_propagate_all_variants"
  add_index "spree_stock_locations", ["state_id"], name: "index_spree_stock_locations_on_state_id"

  create_table "spree_stock_movements", force: :cascade do |t|
    t.integer  "stock_item_id"
    t.integer  "quantity",        default: 0
    t.string   "action"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "originator_id"
    t.string   "originator_type"
  end

  add_index "spree_stock_movements", ["stock_item_id"], name: "index_spree_stock_movements_on_stock_item_id"

  create_table "spree_stock_transfers", force: :cascade do |t|
    t.string   "type"
    t.string   "reference"
    t.integer  "source_location_id"
    t.integer  "destination_location_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "number"
  end

  add_index "spree_stock_transfers", ["destination_location_id"], name: "index_spree_stock_transfers_on_destination_location_id"
  add_index "spree_stock_transfers", ["number"], name: "index_spree_stock_transfers_on_number"
  add_index "spree_stock_transfers", ["source_location_id"], name: "index_spree_stock_transfers_on_source_location_id"

  create_table "spree_store_credit_categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "spree_store_credit_events", force: :cascade do |t|
    t.integer  "store_credit_id",                                          null: false
    t.string   "action",                                                   null: false
    t.decimal  "amount",             precision: 8, scale: 2
    t.string   "authorization_code",                                       null: false
    t.decimal  "user_total_amount",  precision: 8, scale: 2, default: 0.0, null: false
    t.integer  "originator_id"
    t.string   "originator_type"
    t.datetime "deleted_at"
    t.datetime "created_at",                                               null: false
    t.datetime "updated_at",                                               null: false
  end

  add_index "spree_store_credit_events", ["originator_id", "originator_type"], name: "spree_store_credit_events_originator"
  add_index "spree_store_credit_events", ["store_credit_id"], name: "index_spree_store_credit_events_on_store_credit_id"

  create_table "spree_store_credit_types", force: :cascade do |t|
    t.string   "name"
    t.integer  "priority"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "spree_store_credit_types", ["priority"], name: "index_spree_store_credit_types_on_priority"

  create_table "spree_store_credits", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "category_id"
    t.integer  "created_by_id"
    t.decimal  "amount",            precision: 8, scale: 2, default: 0.0, null: false
    t.decimal  "amount_used",       precision: 8, scale: 2, default: 0.0, null: false
    t.text     "memo"
    t.datetime "deleted_at"
    t.string   "currency"
    t.decimal  "amount_authorized", precision: 8, scale: 2, default: 0.0, null: false
    t.integer  "originator_id"
    t.string   "originator_type"
    t.integer  "type_id"
    t.datetime "created_at",                                              null: false
    t.datetime "updated_at",                                              null: false
  end

  add_index "spree_store_credits", ["deleted_at"], name: "index_spree_store_credits_on_deleted_at"
  add_index "spree_store_credits", ["originator_id", "originator_type"], name: "spree_store_credits_originator"
  add_index "spree_store_credits", ["type_id"], name: "index_spree_store_credits_on_type_id"
  add_index "spree_store_credits", ["user_id"], name: "index_spree_store_credits_on_user_id"

  create_table "spree_stores", force: :cascade do |t|
    t.string   "name"
    t.string   "url"
    t.text     "meta_description"
    t.text     "meta_keywords"
    t.string   "seo_title"
    t.string   "mail_from_address"
    t.string   "default_currency"
    t.string   "code"
    t.boolean  "default",           default: false, null: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "spree_stores", ["code"], name: "index_spree_stores_on_code"
  add_index "spree_stores", ["default"], name: "index_spree_stores_on_default"
  add_index "spree_stores", ["url"], name: "index_spree_stores_on_url"

  create_table "spree_taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "spree_taggings", ["context"], name: "index_spree_taggings_on_context"
  add_index "spree_taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "spree_taggings_idx", unique: true
  add_index "spree_taggings", ["tag_id"], name: "index_spree_taggings_on_tag_id"
  add_index "spree_taggings", ["taggable_id", "taggable_type", "tagger_id", "context"], name: "spree_taggings_idy"
  add_index "spree_taggings", ["taggable_id"], name: "index_spree_taggings_on_taggable_id"
  add_index "spree_taggings", ["taggable_type"], name: "index_spree_taggings_on_taggable_type"
  add_index "spree_taggings", ["tagger_id", "tagger_type"], name: "index_spree_taggings_on_tagger_id_and_tagger_type"
  add_index "spree_taggings", ["tagger_id"], name: "index_spree_taggings_on_tagger_id"

  create_table "spree_tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "spree_tags", ["name"], name: "index_spree_tags_on_name", unique: true

  create_table "spree_tax_categories", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.boolean  "is_default",  default: false
    t.datetime "deleted_at"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "tax_code"
  end

  add_index "spree_tax_categories", ["deleted_at"], name: "index_spree_tax_categories_on_deleted_at"
  add_index "spree_tax_categories", ["is_default"], name: "index_spree_tax_categories_on_is_default"

  create_table "spree_tax_rates", force: :cascade do |t|
    t.decimal  "amount",             precision: 8, scale: 5
    t.integer  "zone_id"
    t.integer  "tax_category_id"
    t.boolean  "included_in_price",                          default: false
    t.datetime "created_at",                                                 null: false
    t.datetime "updated_at",                                                 null: false
    t.string   "name"
    t.boolean  "show_rate_in_label",                         default: true
    t.datetime "deleted_at"
  end

  add_index "spree_tax_rates", ["deleted_at"], name: "index_spree_tax_rates_on_deleted_at"
  add_index "spree_tax_rates", ["included_in_price"], name: "index_spree_tax_rates_on_included_in_price"
  add_index "spree_tax_rates", ["show_rate_in_label"], name: "index_spree_tax_rates_on_show_rate_in_label"
  add_index "spree_tax_rates", ["tax_category_id"], name: "index_spree_tax_rates_on_tax_category_id"
  add_index "spree_tax_rates", ["zone_id"], name: "index_spree_tax_rates_on_zone_id"

  create_table "spree_taxonomies", force: :cascade do |t|
    t.string   "name",                   null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "position",   default: 0
  end

  add_index "spree_taxonomies", ["position"], name: "index_spree_taxonomies_on_position"

  create_table "spree_taxons", force: :cascade do |t|
    t.integer  "parent_id"
    t.integer  "position",          default: 0
    t.string   "name",                          null: false
    t.string   "permalink"
    t.integer  "taxonomy_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.string   "icon_file_name"
    t.string   "icon_content_type"
    t.integer  "icon_file_size"
    t.datetime "icon_updated_at"
    t.text     "description"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "meta_title"
    t.string   "meta_description"
    t.string   "meta_keywords"
    t.integer  "depth"
  end

  add_index "spree_taxons", ["lft"], name: "index_spree_taxons_on_lft"
  add_index "spree_taxons", ["name"], name: "index_spree_taxons_on_name"
  add_index "spree_taxons", ["parent_id"], name: "index_taxons_on_parent_id"
  add_index "spree_taxons", ["permalink"], name: "index_taxons_on_permalink"
  add_index "spree_taxons", ["position"], name: "index_spree_taxons_on_position"
  add_index "spree_taxons", ["rgt"], name: "index_spree_taxons_on_rgt"
  add_index "spree_taxons", ["taxonomy_id"], name: "index_taxons_on_taxonomy_id"

  create_table "spree_trackers", force: :cascade do |t|
    t.string   "analytics_id"
    t.boolean  "active",       default: true
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "spree_trackers", ["active"], name: "index_spree_trackers_on_active"

  create_table "spree_users", force: :cascade do |t|
    t.string   "encrypted_password",     limit: 128
    t.string   "password_salt",          limit: 128
    t.string   "email"
    t.string   "remember_token"
    t.string   "persistence_token"
    t.string   "reset_password_token"
    t.string   "perishable_token"
    t.integer  "sign_in_count",                      default: 0, null: false
    t.integer  "failed_attempts",                    default: 0, null: false
    t.datetime "last_request_at"
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "login"
    t.integer  "ship_address_id"
    t.integer  "bill_address_id"
    t.string   "authentication_token"
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.string   "spree_api_key",          limit: 48
  end

  add_index "spree_users", ["spree_api_key"], name: "index_spree_users_on_spree_api_key"

  create_table "spree_variants", force: :cascade do |t|
    t.string   "sku",                                      default: "",    null: false
    t.decimal  "weight",          precision: 8,  scale: 2, default: 0.0
    t.decimal  "height",          precision: 8,  scale: 2
    t.decimal  "width",           precision: 8,  scale: 2
    t.decimal  "depth",           precision: 8,  scale: 2
    t.datetime "deleted_at"
    t.boolean  "is_master",                                default: false
    t.integer  "product_id"
    t.decimal  "cost_price",      precision: 10, scale: 2
    t.integer  "position"
    t.string   "cost_currency"
    t.boolean  "track_inventory",                          default: true
    t.integer  "tax_category_id"
    t.datetime "updated_at"
    t.datetime "discontinue_on"
  end

  add_index "spree_variants", ["deleted_at"], name: "index_spree_variants_on_deleted_at"
  add_index "spree_variants", ["discontinue_on"], name: "index_spree_variants_on_discontinue_on"
  add_index "spree_variants", ["is_master"], name: "index_spree_variants_on_is_master"
  add_index "spree_variants", ["position"], name: "index_spree_variants_on_position"
  add_index "spree_variants", ["product_id"], name: "index_spree_variants_on_product_id"
  add_index "spree_variants", ["sku"], name: "index_spree_variants_on_sku"
  add_index "spree_variants", ["tax_category_id"], name: "index_spree_variants_on_tax_category_id"
  add_index "spree_variants", ["track_inventory"], name: "index_spree_variants_on_track_inventory"

  create_table "spree_zone_members", force: :cascade do |t|
    t.integer  "zoneable_id"
    t.string   "zoneable_type"
    t.integer  "zone_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "spree_zone_members", ["zone_id"], name: "index_spree_zone_members_on_zone_id"
  add_index "spree_zone_members", ["zoneable_id", "zoneable_type"], name: "index_spree_zone_members_on_zoneable_id_and_zoneable_type"

  create_table "spree_zones", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.boolean  "default_tax",        default: false
    t.integer  "zone_members_count", default: 0
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "kind"
  end

  add_index "spree_zones", ["default_tax"], name: "index_spree_zones_on_default_tax"
  add_index "spree_zones", ["kind"], name: "index_spree_zones_on_kind"

  create_table "trade_forms", force: :cascade do |t|
    t.string   "business_name"
    t.string   "greeting"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "phone_number"
    t.string   "address"
    t.string   "suite"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
    t.string   "country"
    t.string   "web_site_url"
    t.string   "certificate"
    t.text     "information"
    t.string   "image"
    t.text     "about_our_company"
    t.text     "tax_exempt"
    t.boolean  "dropship_e_commerce",    default: false
    t.boolean  "stocking_dealer",        default: false
    t.boolean  "non_stocking_dealer",    default: false
    t.text     "describe_your_business"
    t.string   "contract_details"
    t.boolean  "agree"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  create_table "variants", force: :cascade do |t|
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

  create_table "vendor_categories", force: :cascade do |t|
    t.integer  "vendor_id"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vendor_channels", force: :cascade do |t|
    t.integer  "vendor_id"
    t.integer  "channel_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vendor_companies", force: :cascade do |t|
    t.integer  "vendor_id"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vendor_form_agreements", force: :cascade do |t|
    t.text     "vendor_agreement"
    t.integer  "vendor_form_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "vendor_form_category_forms", force: :cascade do |t|
    t.integer  "vendor_form_id"
    t.integer  "category_form_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "vendor_form_channel_forms", force: :cascade do |t|
    t.integer  "vendor_form_id"
    t.integer  "channel_form_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "vendor_form_option_forms", force: :cascade do |t|
    t.integer  "vendor_form_id"
    t.integer  "option_form_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "vendor_forms", force: :cascade do |t|
    t.string   "business_name"
    t.string   "greeting"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "phone_number"
    t.string   "address"
    t.string   "suite"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
    t.string   "country"
    t.string   "web_site_url_my"
    t.string   "web_site"
    t.text     "information"
    t.string   "image"
    t.integer  "vendor_id"
    t.boolean  "grant_access",    default: false
    t.boolean  "agree"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "vendor_onboarding_forms", force: :cascade do |t|
    t.string   "legal_business_name"
    t.string   "company_name"
    t.string   "vendor_based_in"
    t.string   "vendor_based_in_other"
    t.string   "main_address_street"
    t.string   "main_address_unit"
    t.string   "main_address_city"
    t.string   "main_address_state"
    t.string   "main_address_zip"
    t.string   "main_address_country"
    t.string   "primary_business_name"
    t.string   "primary_business_phone"
    t.string   "primary_business_email"
    t.string   "primary_business_fax"
    t.string   "finance_name"
    t.string   "finance_phone"
    t.string   "finance_email"
    t.string   "finance_fax"
    t.string   "purchase_orders_name"
    t.string   "purchase_orders_phone"
    t.string   "purchase_orders_email"
    t.string   "purchase_orders_fax"
    t.string   "inventory_name"
    t.string   "inventory_phone"
    t.string   "inventory_email"
    t.string   "inventory_fax"
    t.string   "returns_name"
    t.string   "returns_phone"
    t.string   "returns_email"
    t.string   "returns_fax"
    t.string   "product_information_name"
    t.string   "product_information_phone"
    t.string   "product_information_email"
    t.string   "product_information_fax"
    t.string   "customer_service_name"
    t.string   "customer_service_phone"
    t.string   "customer_service_email"
    t.string   "customer_service_fax"
    t.string   "inventory_integration_method"
    t.string   "integrations_contact_name"
    t.string   "integrations_contact_phone"
    t.string   "integrations_contact_email"
    t.string   "integrations_contact_fax"
    t.string   "returns_contact_name"
    t.string   "returns_contact_phone"
    t.string   "returns_contact_email"
    t.string   "returns_contact_fax"
    t.string   "returns_address_street"
    t.string   "returns_address_unit"
    t.string   "returns_address_city"
    t.string   "returns_address_state"
    t.string   "returns_address_zip"
    t.string   "returns_address_country"
    t.string   "preferred_shipping_method"
    t.text     "protocol_for_freight_shipments"
    t.string   "ship_alone_items"
    t.string   "average_inventory_levels"
    t.string   "typical_shipping_lead_time_count"
    t.string   "typical_shipping_lead_time_day"
    t.string   "average_inventory_replenishment_time_count"
    t.string   "average_inventory_replenishment_time_day"
    t.string   "average_inventory_replenishment_time_other"
    t.string   "method"
    t.string   "method_other"
    t.string   "frequency"
    t.string   "frequency_other"
    t.string   "costs_fees"
    t.string   "if_so_costs_fees"
    t.string   "requirements_for_purchase_orders"
    t.string   "if_yes_requirements_for_purchase_orders"
    t.text     "imap_pricing"
    t.text     "merchandising"
    t.integer  "vendor_id"
    t.boolean  "grants_access",                              default: false
    t.string   "costs_fees_radio"
    t.text     "w_9_form"
    t.text     "certificate"
    t.text     "inventory_integration_method_other"
    t.text     "contact_other_title"
    t.text     "contact_other_name"
    t.text     "contact_other_phone"
    t.text     "contact_other_email"
    t.text     "contact_other_fax"
    t.boolean  "agree"
    t.datetime "created_at",                                                 null: false
    t.datetime "updated_at",                                                 null: false
  end

  create_table "vendors", force: :cascade do |t|
    t.string   "email",                                default: "",    null: false
    t.string   "encrypted_password",                   default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                        default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.boolean  "admin",                                default: false
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
    t.boolean  "terms_and_condition",                  default: false
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
    t.integer  "parent_vendor_id"
    t.string   "spree_api_key",             limit: 48
    t.integer  "ship_address_id"
    t.integer  "bill_address_id"
    t.integer  "account_id"
    t.string   "pas_decrypt"
    t.integer  "temperature",                          default: 0
  end

  add_index "vendors", ["confirmation_token"], name: "index_vendors_on_confirmation_token", unique: true
  add_index "vendors", ["email"], name: "index_vendors_on_email", unique: true
  add_index "vendors", ["reset_password_token"], name: "index_vendors_on_reset_password_token", unique: true

  create_table "vendors_roles", id: false, force: :cascade do |t|
    t.integer "vendor_id"
    t.integer "role_id"
  end

  add_index "vendors_roles", ["vendor_id", "role_id"], name: "index_vendors_roles_on_vendor_id_and_role_id"

  create_table "visit_cities", force: :cascade do |t|
    t.string   "country_name"
    t.string   "city"
    t.string   "latitude"
    t.string   "longitude"
    t.integer  "count_visit",  default: 0
    t.integer  "radius",       default: 0
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

end
