class AddProductToVariants < ActiveRecord::Migration
  def change
    add_reference :variants, :product, index: true
  end
end
