class User < ApplicationRecord
  has_many :products
  has_many :orders
  has_many :reviews
  validates :username, presence: true
  validates :username, uniqueness: true
  validates :email, presence: true

end
