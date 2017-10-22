class AddPurchaseDatetimeToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :purchase_timestamp, :datetime
  end
end
