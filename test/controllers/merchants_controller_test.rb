require "test_helper"

describe MerchantsController do
  let(:merchant) {merchants(:sappy1)}
  let(:other_merchant) {merchants(:sappy2)}

  describe "logged in merchants" do

    it "merchants can access their own account page" do
        login(merchant, :github)
        flash[:success].must_equal "sappy1 is logged in!"
        get merchant_path(merchant.id)
        must_respond_with :success
    end

    it "merchants can't access other merchants account page" do
        login(merchant, :github)
        flash[:success].must_equal "sappy1 is logged in!"
        get merchant_path(other_merchant.id)
        flash[:status].must_equal :error
        flash[:result_text].must_equal "Unauthorized user"
    end

  end

  describe "guests" do

    it "guest can't access any account/merchant page" do
        get merchant_path(merchant.id)
        flash[:status].must_equal :error
        flash[:result_text].must_equal "Unauthorized user"
        get merchant_path(other_merchant.id)
        flash[:status].must_equal :error
        flash[:result_text].must_equal "Unauthorized user"
    end

  end

end
