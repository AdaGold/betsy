class Order < ApplicationRecord
  has_many :orderitems
  has_many :products, :through => :orderitems
  validates :status, presence: true

end
