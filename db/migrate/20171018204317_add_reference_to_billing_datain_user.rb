class AddReferenceToBillingDatainUser < ActiveRecord::Migration[5.1]
  def change
    add_reference :users, :billing_datum, foreign_key: true
  end
end
