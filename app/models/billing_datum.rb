class BillingDatum < ApplicationRecord
  has_many  :orders
end
