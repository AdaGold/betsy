class Foreignkey < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :orderitems, :orders
  end
end
