require "test_helper"

describe MerchantsController do

  describe "logged in merchants" do

    it "merchants can access their own account page" do
        @merchant = merchants(:sappy1)
        login(@merchant, :github)

        get merchant_path(@merchant.id)
        must_respond_with :success

    end

  end

end
