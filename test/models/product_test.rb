require "test_helper"
  #needs to write in two tests for scopes on the model

describe Product do
  let(:product) { Product.new }
  let(:tree1) {products(:tree1)}
  let(:tree2) {products(:tree2)}


  it "must have a name" do
    tree1.valid?.must_equal true
    tree1.name = nil
    tree1.valid?.must_equal false
    tree1.save
    tree1.errors.keys.must_include :name
  end

  it "must have a unique name" do
    tree1.name = "Tree2"
    tree1.valid?.must_equal false

  end

  it "must have a price" do
    tree1.valid?.must_equal true
    tree1.price = nil
    tree1.valid?.must_equal false

  end

  it "price must be a number" do
    tree1.valid?.must_equal true
    tree1.price = nil
    tree1.valid?.must_equal false
    tree1.price = "haha"
    tree1.valid?.must_equal false
  end

  it "price must be greater than 0" do
    tree1.valid?.must_equal true
    tree1.price = 1
    tree1.valid?.must_equal true
    tree1.price = 0
    tree1.valid?.must_equal false
    tree1.price = -1
    tree1.valid?.must_equal false
  end

  it "must belong to a merchant" do
    tree1.valid?.must_equal true
    tree1.merchant = nil
    tree1.valid?.must_equal false
  end

  it "merchant must be a kind of merchant object" do
    tree1.merchant.must_be_kind_of Merchant
  end

  describe "Product.get_products method" do
    let(:merchant) { merchants(:sappy1) }
    let(:categories) { products(:tree1).categories }
    it "returns all products when the user does not filter category or merchant" do
      products = Product.get_products()
      products.must_equal Product.all
    end
    it "filters products by category" do
      products = Product.get_products(a_category: categories)
      products.must_equal Product.where(categories: categories)
    end
    it "filters products by merchant" do
      products = Product.get_products(a_merchant: merchant.id)
      products.must_equal Product.where(merchant_id: merchant.id)
    end
    it "filters products by category and merchant" do
      products = Product.get_products(a_category: categories, a_merchant: merchant.id)

      products.must_equal Product.where(categories: categories, merchant_id: merchant.id)
    end
    it "does returns all products when the user submits invalid filters" do
      skip
      #TODO: Write the method to prevent users from inputting invalid filter params
      products = Product.get_products(a_category: "fake category")
      products.must_equal Product.all
    end
  end

  it "can retrieve reviews" do
    tree1.reviews.each do |r|
      r.must_be_kind_of Review
    end
  end

  describe "self.categories" do
    it "returns an array the categories that products currently belong to" do
      categories = Product.categories
      categories.must_be_kind_of Array
      Product.categories.must_include "indoor"
      Product.categories.must_include "outdoor"
    end
    it "returns an empty array if there are no categories attached to any products" do

    end
    it "returns a unique array of categories" do
      
    end
  end
end
