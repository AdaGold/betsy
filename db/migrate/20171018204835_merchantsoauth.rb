class Merchantsoauth < ActiveRecord::Migration[5.1]
  def change
    add_column :merchants, :uid, :integer, null: false
    add_column :merchants, :provider, :string, null: false
  end
end
