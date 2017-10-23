class MerchantHasProducts < ActiveRecord::Migration[5.1]
  def change
    add_reference :products, :merchant, foreign_key: true
  end
end
