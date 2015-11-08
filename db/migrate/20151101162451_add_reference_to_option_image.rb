class AddReferenceToOptionImage < ActiveRecord::Migration
  def change
    add_reference :option_images, :option_value, index: true
  end
end
