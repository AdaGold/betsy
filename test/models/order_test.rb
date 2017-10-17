require "test_helper"

describe Order do
  let(:one) { orders(:one) }

  it "must have one or more order items" do
    one.orderitems.each do |o|
      o.must_be_kind_of Orderitem
    end
  end

  it "can access products in the order" do
    one.products.each do |o|
      o.must_be_kind_of Product
    end
  end
end
