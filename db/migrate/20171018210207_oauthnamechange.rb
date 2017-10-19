class Oauthnamechange < ActiveRecord::Migration[5.1]
  def change
    remove_column :merchants, :uid
    remove_column :merchants, :provider

    add_column :merchants, :oauth_uid, :integer, null: false
    add_column :merchants, :oauth_provider, :string, null: false
  end
end
