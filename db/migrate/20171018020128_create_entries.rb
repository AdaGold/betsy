class CreateEntries < ActiveRecord::Migration[5.1]
  def change
    create_table :entries do |t|
      t.boolean :shipping_status
      t.boolean :purchase_status

      t.timestamps
    end
  end
end
