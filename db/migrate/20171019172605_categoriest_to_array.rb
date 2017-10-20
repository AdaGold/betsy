class CategoriestToArray < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :categories, :string, array:true, default: []
  end
end
