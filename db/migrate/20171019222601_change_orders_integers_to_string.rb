class ChangeOrdersIntegersToString < ActiveRecord::Migration[5.1]
  def change
    change_column :orders, :zipcode, :string
    change_column :orders, :cc_number, :string
    change_column :orders, :cc_security, :string
    change_column :orders, :billingzip, :string
  end
end
