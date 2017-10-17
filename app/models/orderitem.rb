class Orderitem < ApplicationRecord
  belongs_to :product
  belongs_to :order
end
