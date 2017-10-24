require "test_helper"

describe Item do
  let(:item) { items(:converse_no_order) }

  it "item should be valid" do
    item.valid?.must_equal true
  end

  it "Item should be invlaid without a shipping_status" do
    item.valid?.must_equal true
    item.shipping_status = nil
    item.valid?.must_equal false
  end

  it "Item should be invlaid without a shipping_status" do
    item.valid?.must_equal true
    item.purchase_status = nil
    item.valid?.must_equal false
  end

  describe "purchase" do
    it "should be truthy if successful" do
      item = items(:converse_no_order)
      order = orders(:mias_pending_order)
      result = item.purchase(order.id)

      result.must_equal true


    end
    it "should return false with item that is already purchased" do
      item = items(:converse_ordered)
      order = orders(:mias_pending_order)
      result = item.purchase(order.id)

      result.must_equal false
    end

  end

  describe "ship" do
    it "should return true if successful" do
      item = items(:converse_no_order)
      order = orders(:mias_pending_order)
      result = item.purchase(order.id)

      result.must_equal true

      result = item.ship(order.id)
      result.must_equal true
    end

    it "should return false if item is not purchased" do
      item = items(:converse_no_order)
      order = orders(:mias_pending_order)

      result = item.ship(order.id)

      result.must_equal false
    end

    it "should return false if input order id does not match it's order id" do
      item = items(:converse_no_order)
      order = orders(:mias_pending_order)
      result = item.purchase(order.id)

      result.must_equal true

      result = item.ship("false_id")
      result.must_equal false
    end

  end

end
