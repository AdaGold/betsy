class UpdateProductsPriceToInteger < ActiveRecord::Migration[5.1]
  def change
    change_column :products, :price, :float
  end
end
