class ChangeCcNumberToBigint < ActiveRecord::Migration[5.1]
  def change
    change_column :orders, :cc_number, :bigint
  end
end
