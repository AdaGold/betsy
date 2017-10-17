class ProductQuantity < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :quantity, :string
  end
end
