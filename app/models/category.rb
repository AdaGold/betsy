class Category < ApplicationRecord
  # add through: to associate join table
  has_and_belongs_to_many :products, through: :categories_products
  validates :name, presence: true
  validates :name, uniqueness: true

  # before_validation :fix_category


  # private
  # def fix_category
  #   if self.category
  #     self.category = self.category.downcase.singularize
  #   end
  # end

  def show_available
    Product.where(visibility: true)
  end
end
