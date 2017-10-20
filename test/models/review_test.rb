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

  it "title must be present" do
    review1.valid?.must_equal true
    review1.title = nil
    review1.valid?.must_equal false
    review1.save
    review1.errors.keys.must_include :title
  end

  it "title should be at least 2 characters long" do
    review1.valid?.must_equal true
    review1.title = "a"
    review1.valid?.must_equal false
    review1.save
    review1.errors.keys.must_include :title
  end

  it "title should be at shorter than 100 characters " do
    review1.valid?.must_equal true
    review1.title = "a" * 101
    review1.valid?.must_equal false
    review1.save
    review1.errors.keys.must_include :title
  end
  it "review_text must be present" do
    review1.valid?.must_equal true
    review1.review_text = nil
    review1.valid?.must_equal false
    review1.save
    review1.errors.keys.must_include :review_text
  end

  it "review_text should be at least 2 characters long" do
    review1.valid?.must_equal true
    review1.review_text = "t"
    review1.valid?.must_equal false
    review1.save
    review1.errors.keys.must_include :review_text
  end

  it "review_text should be at shorter than 700 characters " do
    review1.valid?.must_equal true
    review1.review_text = "n" * 701
    review1.valid?.must_equal false
    review1.save
    review1.errors.keys.must_include :review_text
  end

end
