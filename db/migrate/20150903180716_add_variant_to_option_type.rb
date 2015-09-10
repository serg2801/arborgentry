class AddVariantToOptionType < ActiveRecord::Migration
  def change
    add_reference :option_types, :variant, index: true
  end
end
