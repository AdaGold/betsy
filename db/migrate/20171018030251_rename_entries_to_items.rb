class RenameEntriesToItems < ActiveRecord::Migration[5.1]
  def change
    rename_table :entries, :items
  end
end
