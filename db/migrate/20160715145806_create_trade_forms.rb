class CreateTradeForms < ActiveRecord::Migration
  def change
    create_table :trade_forms do |t|
      t.string  :business_name
      t.string  :greeting
      t.string  :first_name
      t.string  :last_name
      t.string  :email
      t.string  :phone_number
      t.string  :address
      t.string  :suite
      t.string  :city
      t.string  :state
      t.string  :zipcode
      t.string  :country
      t.string  :web_site_url
      t.string  :certificate
      t.text    :information
      t.string  :image
      t.text    :about_our_company
      t.text    :tax_exempt
      t.boolean :dropship_e_commerce,    default: false
      t.boolean :stocking_dealer,        default: false
      t.boolean :non_stocking_dealer,    default: false
      t.text    :describe_your_business
      t.string  :contract_details
      t.boolean  :agree

      t.timestamps null: false
    end
  end
end
