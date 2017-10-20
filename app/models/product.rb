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
  # TODO: Add a validation for quantyty
  def self.get_products(a_category: "all", a_merchant: "all")
    if ["all", nil].include?(a_category) && ["all", nil, ""].include?(a_merchant)
      return Product.all
    elsif ["all", nil].include?(a_category)
      return Product.where(merchant_id: a_merchant)
    elsif ["all", nil, ""].include?(a_merchant)
      return Product.where(category: a_category)
    else
      return Product.where(category: a_category, merchant_id: a_merchant)
    end
  end

  def average_rating
    return "Nothing to show" if reviews.count == 0
    sum = 0
    reviews.each do |review|
      sum += review.rating
    end
    return (sum.to_f/reviews.count).round(1)
  end

  # def first_10_reviews
  #   return reviews.all.limit(10)
  # end

end
