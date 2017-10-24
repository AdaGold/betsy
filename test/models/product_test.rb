require "test_helper"

describe Product do
  let(:converse) { products(:converse) }
  let(:coffee) { products(:coffee) }
  describe "available_items" do
    it "should give an array" do
      converse.available_items.must_be_instance_of Array
      converse.available_items.length.must_equal 1
    end
    it "should return false if none are available" do
      coffee.available_items.must_equal false
    end

  end

  describe "num_available" do
    it "should return a number of items available" do
      converse.num_available.must_equal 1

    end
    it "should return 0 if no items are available" do
      coffee.num_available.must_equal 0

    end
  end
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

  it "Must have an associated user id" do
    converse.user = nil
    converse.valid?.must_equal false
  end

  describe "relationship to items" do
    it "can have many items" do

    end
  end
end
