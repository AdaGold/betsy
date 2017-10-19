class RemoveFkCategoryIdFromProducts < ActiveRecord::Migration[5.1]
  def change
    remove_reference
  end
end
