require "test_helper"

describe OrderProduct do
  let(:order_product) { OrderProduct.new }

  describe "validations" do

  end

  describe "relations" do

  end

  describe "items_available?" do
    it "should return true if product has available inventory" do
      entry = OrderProduct.find_by(id: order_products(:mias_pending_products).id)
      result = entry.items_available?
      result.must_equal true

    end

    it "should return false if product is out of stock" do
      entry = OrderProduct.find_by(id: order_products(:guest_pending_products).id)
      result = entry.items_available?
      result.must_equal false

    end
  end

  describe "pending?" do
    it "should return true if it's order is pending" do
      entry = order_products(:mias_pending_products)
      result = entry.pending?
      result.must_equal true

    end

    it "should return false if it's order is not pending" do
      entry = order_products(:pencil_paid_order)
      order = entry.order
      order.must_equal orders(:paid_order)
      result = entry.pending?
      # binding.pry
      result.must_equal false
    end
  end
end
