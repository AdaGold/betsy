class UpdateProductQuantityFromStringToInt < ActiveRecord::Migration[5.1]
  def change
    change_column :products, :quantity, 'integer USING CAST(products.quantity AS integer)'
  end
end
