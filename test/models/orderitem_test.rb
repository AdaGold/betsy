require "test_helper"

describe Orderitem do
  let(:one) { orderitems(:one) }

  it "has an order" do
    one.order.must_be_kind_of Order
  end

  it "has a product" do
    one.product.must_be_kind_of Product
  end

  it "quantity must be present" do
    one.valid?.must_equal true
    one.quantity = nil
    one.valid?.must_equal false
  end

  it "quantity must be an integer" do
    one.valid?.must_equal true
    one.quantity = 4.5
    one.valid?.must_equal false
    one.quantity = "treehouse"
    one.valid?.must_equal false
  end

  it "must be quantity greater than 0" do
    one.valid?.must_equal true
    one.quantity = 1
    one.valid?.must_equal true
    one.quantity = 0
    one.valid?.must_equal false
    one.quantity = -1
    one.valid?.must_equal false
  end

  it "must have a product" do
    one.valid?.must_equal true
    one.product = nil
    one.valid?.must_equal false
  end

  it "must have an order" do
    one.valid?.must_equal true
    one.order = nil
    one.valid?.must_equal false
  end



end
