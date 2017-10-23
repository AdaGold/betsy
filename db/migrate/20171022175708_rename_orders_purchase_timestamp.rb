class RenameOrdersPurchaseTimestamp < ActiveRecord::Migration[5.1]
  def change
    rename_column :orders, :purchase_timestamp, :purchase_datetime
  end
end
