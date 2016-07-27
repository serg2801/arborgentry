class FixColumnNameOnboardingForm < ActiveRecord::Migration
  def change
    rename_column :vendor_onboarding_forms, :user_id, :vendor_id
  end
end
