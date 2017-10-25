class AddQuantityToOrderProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :order_products, :quantity, :Integer
  end
end
