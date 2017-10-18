class Product < ApplicationRecord
  has_many :reviews
  has_many :entries
  belongs_to :user
  has_and_belongs_to_many :categories
  validates :name, uniqueness: true
  validates :name, presence: true
  validates :price, presence: true
  validates :category, presence: true
  validates :price, numericality: true
end
