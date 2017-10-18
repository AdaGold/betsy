require "test_helper"

describe OrderProduct do
  let(:order_product) { OrderProduct.new }

  it "must be valid" do
    value(order_product).must_be :valid?
  end
end
