require "test_helper"

describe Order do
  let(:order) { Order.new }
  let(:pending_order) { orders(:pending_order)}
  let(:paid_order)  { orders(:paid_order) }
  let(:shipped_order) { orders(:shipped_order)}
  let(:canceled_order) { orders(:canceled_order)}

  describe "relations" do
    it "has a user" do

    end

    it "has a billing datum if paid, shipped or canceled" do

    end

    it "does not have billing data if pending" do

    end
    it "should have a collection of order_products" do

    end
  end

  describe "validations" do
    it "must have session_id" do

    end

    it "must have an order_status" do

    end

    it "must have an order status of pending, paid, shipped or canceled" do

    end

    it "new orders should have status of pending" do
    end

    it "rejects invalid order statuses" do

    end

    it "must have a user if authenticated user is logged in" do

    end

    it "must have an associated billing datum if paid, shipped or canceled" do

    end

  end
end
