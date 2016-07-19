class CreateVendorOnboardingForms < ActiveRecord::Migration
  def change
    create_table :vendor_onboarding_forms do |t|

      t.string  :legal_business_name
      t.string  :company_name
      t.string  :vendor_based_in
      t.string  :vendor_based_in_other
      t.string  :main_address_street
      t.string  :main_address_unit
      t.string  :main_address_city
      t.string  :main_address_state
      t.string  :main_address_zip
      t.string  :main_address_country
      t.string  :primary_business_name
      t.string  :primary_business_phone
      t.string  :primary_business_email
      t.string  :primary_business_fax
      t.string  :finance_name
      t.string  :finance_phone
      t.string  :finance_email
      t.string  :finance_fax
      t.string  :purchase_orders_name
      t.string  :purchase_orders_phone
      t.string  :purchase_orders_email
      t.string  :purchase_orders_fax
      t.string  :inventory_name
      t.string  :inventory_phone
      t.string  :inventory_email
      t.string  :inventory_fax
      t.string  :returns_name
      t.string  :returns_phone
      t.string  :returns_email
      t.string  :returns_fax
      t.string  :product_information_name
      t.string  :product_information_phone
      t.string  :product_information_email
      t.string  :product_information_fax
      t.string  :customer_service_name
      t.string  :customer_service_phone
      t.string  :customer_service_email
      t.string  :customer_service_fax
      t.string  :inventory_integration_method
      t.string  :integrations_contact_name
      t.string  :integrations_contact_phone
      t.string  :integrations_contact_email
      t.string  :integrations_contact_fax
      t.string  :returns_contact_name
      t.string  :returns_contact_phone
      t.string  :returns_contact_email
      t.string  :returns_contact_fax
      t.string  :returns_address_street
      t.string  :returns_address_unit
      t.string  :returns_address_city
      t.string  :returns_address_state
      t.string  :returns_address_zip
      t.string  :returns_address_country
      t.string  :preferred_shipping_method
      t.text    :protocol_for_freight_shipments
      t.string  :ship_alone_items
      t.string  :average_inventory_levels
      t.string  :typical_shipping_lead_time_count
      t.string  :typical_shipping_lead_time_day
      t.string  :average_inventory_replenishment_time_count
      t.string  :average_inventory_replenishment_time_day
      t.string  :average_inventory_replenishment_time_other
      t.string  :method
      t.string  :method_other
      t.string  :frequency
      t.string  :frequency_other
      t.string  :costs_fees
      t.string  :if_so_costs_fees
      t.string  :requirements_for_purchase_orders
      t.string  :if_yes_requirements_for_purchase_orders
      t.text    :imap_pricing
      t.text    :merchandising
      t.integer :user_id
      t.boolean :grants_access, default: false
      t.string  :costs_fees_radio
      t.text    :w_9_form
      t.text    :certificate
      t.text    :inventory_integration_method_other
      t.text    :contact_other_title
      t.text    :contact_other_name
      t.text    :contact_other_phone
      t.text    :contact_other_email
      t.text    :contact_other_fax
      t.boolean  :agree

      t.timestamps null: false
    end
  end
end
