class CreateOnboardingProductTypes < ActiveRecord::Migration
  def change
    create_table :onboarding_product_types do |t|

      t.string :name
      t.references :vendor_onboarding_form, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
