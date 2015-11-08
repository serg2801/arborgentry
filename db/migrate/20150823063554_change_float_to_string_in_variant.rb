class ChangeFloatToStringInVariant < ActiveRecord::Migration
  def change
  	change_column :variants, :weight_unit, :string
  end
end
