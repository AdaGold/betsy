class AddUidToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :uid, :integer
  end
end
