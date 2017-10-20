class Product < ApplicationRecord
  has_many :reviews
  has_many :items
  belongs_to :user
  has_and_belongs_to_many :categories
  validates :user_id, presence: true
  validates :name, uniqueness: true
  validates :name, presence: true
  validates :price, presence: true
  # validates :category_id, presence: true
  validates :price, numericality: true
end
