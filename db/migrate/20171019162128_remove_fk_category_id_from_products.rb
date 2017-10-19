class RemoveFkCategoryIdFromProducts < ActiveRecord::Migration[5.1]
  def change
    remove_column :products, :category_id
  end
end
