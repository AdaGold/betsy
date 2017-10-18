class AddForeignKeysToEntries < ActiveRecord::Migration[5.1]
  def change
    add_reference :entries, :product, foreign_key: true
    add_reference :entries, :order, foreign_key: true
  end
end
