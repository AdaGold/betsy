class AddRequiredToProductUser < ActiveRecord::Migration[5.1]
  def change
    change_column_null :products, :user_id, false
  end
end
