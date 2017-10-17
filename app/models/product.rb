class Product < ApplicationRecord
  belongs_to :merchant

  validates :name, presence: true
  validates :name, uniqueness: true
  validates :price, presence: true
  validates :price, numericality: { greater_than: 0 }
  validates :price, numericality: { only_float: true }
  #may need to include integers as well
  validates :merchant_id, presence: true

  def self.get_products(a_category: "all")
    if ["all", nil].include?(a_category)
      return Product.all
    else
      return Product.where(category: a_category)
    end
  end
end
