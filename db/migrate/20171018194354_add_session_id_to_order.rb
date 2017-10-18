class AddSessionIdToOrder < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :session_id, :string
  end
end
