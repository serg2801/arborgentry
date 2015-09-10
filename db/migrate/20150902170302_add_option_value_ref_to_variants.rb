class AddOptionValueRefToVariants < ActiveRecord::Migration
  def change
    add_reference :variants, :option_value, index: true
  end
end
