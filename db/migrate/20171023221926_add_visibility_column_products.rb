class AddVisibilityColumnProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :visibility, :boolean, :default => true
  end
end
