class BillingDatum < ApplicationRecord
  has_many  :orders
  validates :email, presence: true
  validates :mailing_address, presence: true
  validates :credit_card_name, presence: true
  validates :credit_card_number, presence: true
  validates :credit_card_cvv, presence: true
  validates :billing_zip_code, presence: true
  
end
