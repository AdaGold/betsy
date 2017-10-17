require "test_helper"
  #needs to write in two tests for scopes on the model

describe Merchant do
  let(:merchant) { Merchant.new }
  let(:sappy1) { merchants(:sappy1) }

  it "must have a username" do
    sappy1.valid?.must_equal true
    sappy1.username = nil
    sappy1.valid?.must_equal false
    sappy1.save
    sappy1.errors.keys.must_include :username
  end

  it "must have a unique username" do
    sappy1.username = "sappy2"
    sappy1.valid?.must_equal false
  end

  it "must have an email address" do
    sappy1.valid?.must_equal true
    sappy1.email = nil
    sappy1.valid?.must_equal false
    sappy1.save
    sappy1.errors.keys.must_include :email
  end

  it "must have a unique email" do
    sappy1.email = "sappy2@gmail.com"
    sappy1.valid?.must_equal false
  end

  it "must return the products of the merchant" do
    sappy1.products.must_be_kind_of Enumerable
    sappy1.products.each do |product|
      product.must_be_kind_of Product
    end
  end



end #describe merchant
