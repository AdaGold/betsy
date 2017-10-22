
require "test_helper"

describe User do
  # let(:user) { User.new }
  let(:user) { users(:carl) }

  describe "User Model Validity" do

    it "must be valid with username and email" do
      user.must_be :valid?
    end

    it "Should return invalid without a username" do
      user.valid?.must_equal true
      user.username = nil
      user.valid?.must_equal false
    end

    it "Should be invalid without an email" do
      user.valid?.must_equal true
      user.email = nil
      user.valid?.must_equal false
    end

    it "Should  allow two users to have the same email" do
      user.valid?.must_equal true
      new_user = User.new(username: "Mr Magoo", email: "carl@carlcarle.me")

      user.valid?.must_equal true
      new_user.valid?.must_equal true
    end

    it "Username must be unique" do
      user.valid?.must_equal true
      new_user = User.new(username: "carl carle", email: "sample@sample.com")

      user.valid?.must_equal true
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
