class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.string :customer_email
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.integer :zipcode
      t.string :cc_name
      t.integer :cc_number
      t.string :cc_expiration
      t.integer :cc_security
      t.integer :billingzip

      t.timestamps
    end
  end
end
