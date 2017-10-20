class Product < ApplicationRecord
  belongs_to :merchant
  has_many :orderitems
  has_many :orders, :through => :orderitems
  has_many :reviews


  validates :name, presence: true
  validates :name, uniqueness: true
  validates :price, presence: true
  validates :price, numericality: { greater_than: 0 }
  validates :price, numericality: { only_float: true }
  #may need to include integers as well
  validates :merchant_id, presence: true


  def self.get_products(a_category: "all", a_merchant: "all")
    if ["all", nil].include?(a_category) && ["all", nil, ""].include?(a_merchant)
      return Product.all
    elsif ["all", nil].include?(a_category)
      return Product.where(merchant_id: a_merchant)
    elsif ["all", nil, ""].include?(a_merchant)
      return Product.where("categories @> ?", "{#{a_category}}")
    else
      category_products = Product.where("categories @> ?", "{#{a_category}}")
      merchant_products = Product.where(merchant_id: a_merchant)
      return merchant_products & category_products
    end
  end

  def self.categories
    categories = Product.pluck(:categories).flatten.uniq
  end

  
end
