class Order < ApplicationRecord
  belongs_to :billing_data
  has_many :entries
  belongs_to :user

end
