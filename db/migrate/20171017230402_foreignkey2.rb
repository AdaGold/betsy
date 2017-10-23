class Foreignkey2 < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :orderitems, :products
  end
end
