class CreateBillingData < ActiveRecord::Migration[5.1]
  def change
    create_table :billing_data do |t|
      t.string :email
      t.string :mailing_address
      t.string :credit_card_name
      t.string :credit_card_number
      t.string :credit_card_cvv
      t.string :billing_zip_code

      t.timestamps
    end
  end
end
