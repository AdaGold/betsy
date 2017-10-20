class RemoveBillingDataReferenceFromOrder < ActiveRecord::Migration[5.1]
  def change
    remove_reference(:orders, :billing_data, foreign_key: true)
  end
end
