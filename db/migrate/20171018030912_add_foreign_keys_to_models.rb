class AddForeignKeysToModels < ActiveRecord::Migration[5.1]
  def change
    add_reference :billing_data, :user, foreign_key: true
    add_reference :orders, :user, foreign_key: true
    add_reference :orders, :billing_data, foreign_key: true
    add_reference :reviews, :user, foreign_key: true
    add_reference :reviews, :product, foreign_key: true
    add_reference :products, :category, foreign_key: true
    add_reference :products, :user, foreign_key: true
    add_reference :items, :product, foreign_key: true
    add_reference :items, :order, foreign_key: true
  end
end
