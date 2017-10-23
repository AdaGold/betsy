class DescriptionAnDphot < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :description, :text
    add_column :products, :photo_url, :string
  end
end
