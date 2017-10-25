require "test_helper"

describe User do
  let(:user) { User.new }
  let(:carl) { users(:carl) }

  describe "merchant_entries" do
    it "should return an array" do
      result = carl.merchant_entries

      result.must_be_instance_of Array
    end
    it "everything in the array should be an OrderProduct" do
      result = carl.merchant_entries
      # binding.pry
      result.each do |entry|
        entry.must_be_instance_of OrderProduct
      end

    end

    it "every order should have product tied to merchant" do
      result = carl.merchant_entries
      # binding.pry
      result.each do |entry|
        [products(:converse), products(:flats), products(:coffee), products(:pencil)].must_include entry.product
      end
    end

    it "every entry should be tied to an order that is not pending" do
      result = carl.merchant_entries
      failed_entries = []
      result.each do |entry|
        failed_entries << entry if entry.order.order_status == "pending"
      end
      failed_entries.length.must_equal 0
    end
  end

describe "User Model Validity" do

  it "must be valid with username and email" do
    carl.must_be :valid?
  end

  it "Should return invalid without a username" do
    carl.valid?.must_equal true
    carl.username = nil
    carl.valid?.must_equal false
  end

  it "Should be invalid without an email" do
    carl.valid?.must_equal true
    carl.email = nil
    carl.valid?.must_equal false
  end

  it "Should  allow two users to have the same email" do
    carl.valid?.must_equal true
    new_user = User.new(username: "Mr Magoo", email: "carl@carlcarle.me")

    carl.valid?.must_equal true
    new_user.valid?.must_equal true
  end

  it "Username must be unique" do
    carl.valid?.must_equal true
    new_user = User.new(username: "carl carle", email: "sample@sample.com")

    carl.valid?.must_equal true
    new_user.valid?.must_equal false

  end
end

describe "find_pending_order" do
  it "if a user has a single pending order, it should return one pending order" do
    result = users(:mia).find_pending_order
    result.must_be_instance_of Order

  end

  it "should return false if a user does not have a pending order" do
    result = users(:sophie_no_pending_order).find_pending_order
    result.must_equal false
  end

  it "if a user has multiple pending orders, it should return one pending order" do

  end

  it "if a user has multiple pending orders, it should return a combination of the two orders" do

  end

  it "if a user has multiple pending orders, it should combine them and delete the other ones?" do

  end

end
end
