require "test_helper"
require "pry"

describe Order do
  let(:order) { Order.new }
  let(:order2) { Order.new }
  let(:order3) { Order.new }
  let(:pending_order) { orders(:pending_order)}
  let(:paid_order)  { orders(:paid_order) }
  let(:shipped_order) { orders(:shipped_order)}
  let(:canceled_order) { orders(:canceled_order)}
  let(:guest_pending_order) { orders(:guest_pending_order)}

  describe "relations" do
    it "has a nil user if not logged in" do
      result = guest_pending_order.user
      result.must_equal nil

    end

    it "has a user if authenticated user is logged in" do
      result = pending_order.user
      result.must_be_instance_of User

    end

    it "has a billing datum if paid, shipped or canceled" do
      # binding.pry
      order.order_status = "paid"
      (order.valid?).must_equal false
      order.errors.must_include :billing_data_id
      order.errors[:billing_data_id].must_equal ["must exist"]
      order.billing_data_id = billing_data(:guest_billing_datum).id
      (order.valid?).must_equal true
      order.billing_data.must_be_instance_of BillingDatum


    end

    it "does not need to have billing data if pending" do
      order.order_status.must_equal "pending"
      order.billing_data.must_equal nil
      order.valid?.must_equal true

    end
    it "should have a collection of order_products" do
      order.order_products.must_be_instance_of Array

    end
  end

  describe "validations" do
    it "must have session_id" do
      order.session_id.must_equal nil
      order.valid?.must_equal false

    end


    it "must have an order order_status of pending, paid, shipped or canceled" do
      orders.each do |test_order|
        ["pending","paid", "shipped", "canceled"].must_include test_order.order_status
        test_order.valid?.must_equal true
        test_order.order_status = nil
        test_order.valid?.must_equal false
        test_order.errors.must_include :order_status
        #not sure what message would be
        # test_order.errors[:order_status].must_equal "something"
        test_order.order_status = ""
        test_order.valid?.must_equal false
        test_order.order_status = 39085
        test_order.valid?.must_equal false
        test_order.order_status = "pending"
        test_order.valid?.must_equal true
      end


      # pending_order.order_status.must_equal "pending"
      # pendng_order.valid?.must_equal true
      # pending_order.order_status = nil
      # pending_order.valid?.must_equal false
      #
      # paid_order.order_status.must_equal "paid"
      # paid_order.valid?.must_equal true
      # paid_order.order_status = 5
      # paid_order.valid?.must_equal false
      #
      # shipped_order.order_status.must_equal "shipped"
      # shipped_order.valid?.must_equal true
      # shipped_order.order_status = "wsup"
      # paid_order.valid?.must_equal false
      #
      # canceled_order.order_status.must_equal "canceled"
      # canceled_order.valid?.must_equal true
      # canceled_order.order_status = ""
      # canceled_order.valid?.must_equal false

    end

    it "new orders should have order_status of pending" do
      order.order_status.must_equal "pending"
      another_order = Order.new
      another_order.order_status.must_equal "pending"
    end


    it "must have a user if authenticated user is logged in" do
      #maybe this should be in the controller instead?

    end

    it "must have an associated billing datum if paid, shipped or canceled" do
      ["paid", "shipped", "canceled"].each do |test_order_status|
        order.order_status = test_order_status
        order.valid?.must_equal false
        binding.pry
        order.billing_data = billing_data(:guest_billing_datum)
        order.valid?.must_equal true
        order.billing_data = nil
      end

    end

  end
end
