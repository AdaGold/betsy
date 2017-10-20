class RemoveTimestampsFromCategoriesProducts < ActiveRecord::Migration[5.1]
  def change
    remove_column :categories_products, :created_at, :datetime
    remove_column :categories_products, :updated_at, :datetime
  end
end
