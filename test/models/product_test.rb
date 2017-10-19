require "test_helper"

describe Product do
  let(:converse) {products(:converse)}
  it "A product should be valid when given complete data" do
    converse.valid?.must_equal true
  end

  it "A product must have a name to be valid" do
    converse.name = nil
    converse.valid?.must_equal false
  end

  it "A product must have a unique name to be valid" do
    converse.name = "flats"
    converse.valid?.must_equal false
  end

  it "A product must have a numeric price to be valid" do
    converse.price = nil
    converse.valid?.must_equal false

    converse.price = 9
    converse.valid?.must_equal true

    converse.price = "nine"
    converse.valid?.must_equal false
  end


end
