require "test_helper"

describe Product do
  let(:product) { Product.new }
  let(:tree1) {products(:tree1)}
  let(:tree2) {products(:tree2)}


  it "must have a name" do
    tree1.valid?.must_equal true
    tree1.name = nil
    tree1.valid?.must_equal false
  end

  it "must have a unique name" do
    tree1.name = "Tree2"
    tree1.valid?.must_equal false

  end

  it "must have a price" do

  end

  it "price must be a number" do

  end

  it "price must be greater than 0" do

  end

  it "must belong to a user" do

  end

end
