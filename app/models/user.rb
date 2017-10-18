class User < ApplicationRecord
  has_many :products
  has_many :orders
  has_many :reviews
  belongs_to :billing_datum, optional: true
  validates :username, presence: true
  validates :username, uniqueness: true
  validates :email, presence: true

end
