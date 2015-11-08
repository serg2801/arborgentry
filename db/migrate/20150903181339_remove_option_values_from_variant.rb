class RemoveOptionValuesFromVariant < ActiveRecord::Migration
  def change
    remove_reference :variants, :option_value, index: true
  end
end
