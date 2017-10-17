class Orderitem < ActiveRecord::Migration[5.1]
  def change
    create_table :orderitems do |t|
      t.belongs_to :order, index: true
      t.belongs_to :product, index: true
      t.integer :quantity
      t.timestamps
    end
  end
end
