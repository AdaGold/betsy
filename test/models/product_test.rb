require "test_helper"
  #needs to write in two tests for scopes on the model

describe Product do
  let(:product) { Product.new }
  let(:tree1) {products(:tree1)}
  let(:tree2) {products(:tree2)}

  before do
    tree1.valid?.must_equal true
  end

  describe "validations" do
    it "must have a name" do
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
      tree1.price = nil
      tree1.valid?.must_equal false
    end

    it "price must be a number" do
      tree1.price = nil
      tree1.valid?.must_equal false
      tree1.price = "haha"
      tree1.valid?.must_equal false
    end

    it "price must be greater than 0" do
      tree1.price = 1
      tree1.valid?.must_equal true
      tree1.price = 0
      tree1.valid?.must_equal false
      tree1.price = -1
      tree1.valid?.must_equal false
    end

    it "must belong to a merchant" do
      tree1.merchant = nil
      tree1.valid?.must_equal false
    end

    it "merchant must be a kind of merchant object" do
      tree1.merchant.must_be_kind_of Merchant
    end

    it "must have an integer quantity" do
      tree1.quantity = 2.3
      tree1.valid?.must_equal false
      tree1.quantity = "two"
      tree1.valid?.must_equal false
    end

    it "must have a non-negative quantity" do
      tree1.quantity = 0
      tree1.valid?.must_equal true
      tree1.quantity = -1
      tree1.valid?.must_equal false
    end
  end

  describe "Product.get_products method" do
    let(:merchant) { merchants(:sappy1) }
    let(:categories) { products(:tree1).categories }
    let(:product1) { products(:tree1)}

    it "returns all products when the user does not filter category or merchant" do
      products = Product.get_products()
      products.must_equal Product.all
    end

    it "filters products by category" do
      products = Product.get_products(a_category: categories)

      products.must_equal Product.where("categories @> ?", "{#{categories}}")
    end

    it "filters products by merchant" do
      products = Product.get_products(a_merchant: merchant.id)
      products.must_equal Product.where(merchant_id: merchant.id)
    end

    it "filters products by category and merchant" do
      products = Product.get_products(a_category: categories, a_merchant: merchant.id)

      # products = Product.where("categories @> {#{a_category}} AND merchant_id = #{a_merchant}")

      products.must_equal [product1]
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
    let(:tree1) {products(:tree1)}
    let(:tree2) {products(:tree2)}

    it "returns an array the categories that products currently belong to" do
      categories = Product.categories
      categories.must_be_kind_of Array
      Product.categories.must_include "indoor"
      Product.categories.must_include "outdoor"
    end

    it "returns an empty array if there are no categories attached to any products" do
      tree1.categories.clear
      tree1.save
      tree2.categories.clear
      tree2.save

      categories = Product.categories
      categories.must_be_kind_of Array
      categories.length.must_equal 0
    end

    it "returns a unique array of categories" do
      5.times do |n|
        Product.create :name => "tree#{n}", :price => n, :categories => ["indoor", "halloween", "winter"]
      end

      categories = Product.categories
      unique_categories = Product.categories.uniq
      categories.must_equal unique_categories
    end

    it "returns an empty array if there are no products" do
      Orderitem.all.destroy_all
      Review.all.destroy_all
      Product.all.destroy_all

      Product.categories.must_be_kind_of Array
      Product.categories.length.must_equal 0
    end
  end

  describe "update categories method" do

    it "updates the categories of a product" do
      tree = products(:tree1)
      before = tree.categories.count

      tree.update_categories("spooky")

      tree.categories.count.must_equal (before + 1)
      tree.categories.must_include "spooky"
    end

    it "will not update the categories if the category is already present" do
      tree = products(:tree1)
      before = tree.categories.count

      tree.update_categories("indoor")

      tree.categories.count.must_equal before
    end

  end
end
