class AddOrderProductColumns < ActiveRecord::Migration[5.1]
  def change
    remove_column(:order_products, :quantity)
    add_reference :order_products, :order, foreign_key: true
    add_reference :order_products, :product, foreign_key: true
  end
end
