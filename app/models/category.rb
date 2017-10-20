class Category < ApplicationRecord
  has_and_belongs_to_many :products
  validates :name, presence: true
  validates :name, uniqueness: true

  before_validation :fix_category


  private
  def fix_category
    if self.category
      self.category = self.category.downcase.singularize
    end
  end

end
