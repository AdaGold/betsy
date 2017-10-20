class AddDefaultOrderStatusToOrder < ActiveRecord::Migration[5.1]
  def change
    change_column_default(:orders, :order_status, "pending")
  end
end
