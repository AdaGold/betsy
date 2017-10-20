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
end
