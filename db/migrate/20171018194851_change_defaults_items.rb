class ChangeDefaultsItems < ActiveRecord::Migration[5.1]
  def change
    change_column_default(:items, :shipping_status, false)
    change_column_default(:items, :purchase_status, false)
  end
end
