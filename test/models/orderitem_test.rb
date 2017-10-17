require "test_helper"

describe Orderitem do
  let(:one) { orderitems(:one) }

  it "has an order" do
    one.order.must_be_kind_of Order
  end

  it "has a product" do
    one.product.must_be_kind_of Product 
  end






end
