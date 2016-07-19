class CreateOnboardingTransportations < ActiveRecord::Migration
  def change
    create_table :onboarding_transportations do |t|

      t.string  :ship_from_information_street
      t.string  :ship_from_information_unit
      t.string  :ship_from_information_city
      t.string  :ship_from_information_state
      t.string  :ship_from_information_zip
      t.string  :ship_from_information_country

      t.string  :transportation_contact_name
      t.string  :transportation_contact_phone
      t.string  :transportation_contact_email
      t.string  :transportation_contact_fax

      t.references :vendor_onboarding_form, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
