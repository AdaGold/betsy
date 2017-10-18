require "test_helper"

describe Review do
  let(:review) { Review.new }
  let(:review1) {reviews(:review1)}

  it "rating must be present" do
    review1.valid?.must_equal true
    review1.rating = nil
    review1.valid?.must_equal false
    review1.save
    review1.errors.keys.must_include :rating
  end

  it "rating must be an integer" do
    review1.valid?.must_equal true
    review1.rating = 2.3
    review1.valid?.must_equal false
    review1.rating = "string"
    review1.valid?.must_equal false
  end

  it "rating must be <= 1 and >= 5" do
    review1.valid?.must_equal true
    review1.rating = -1
    review1.valid?.must_equal false
    review1.rating = 6
    review1.valid?.must_equal false
  end

  it "has a product" do
    review1.valid?.must_equal true
    review1.product.must_be_kind_of Product
  end

  it "must have a product" do
    review1.valid?.must_equal true
    review1.product = nil
    review1.valid?.must_equal false
  end


end
