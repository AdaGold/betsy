class AddBillingDatumReferenceToOrder < ActiveRecord::Migration[5.1]
  def change
    add_reference :orders, :billing_datum, foreign_key: true
  end
end
