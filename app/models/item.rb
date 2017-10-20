class Item < ApplicationRecord
  belongs_to :product
  belongs_to :order, optional: true
  validates :shipping_status, inclusion: {in: [true,false]}
  validates :purchase_status, inclusion: {in: [true,false]}

end
