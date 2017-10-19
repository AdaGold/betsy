require "test_helper"

describe SessionsController do

  it "logs in an existing merchant and redirect to root_path" do
    @merchant = merchants(:sappy1)
    start_count = Merchant.count
    login(@merchant, :github)
    Merchant.count.must_equal start_count
    must_redirect_to root_path
    session[:merchant_id].must_equal @merchant.id
  end

  it "must have a username" do
    @merchant = merchants(:sappy1)
    login(@merchant, :github)
    @merchant.username.must_equal "sappy1"
  end

  it "logs in a new user" do
    @merchant = Merchant.new(oauth_provider: "github", oauth_uid: 9999, username: "toolazytomakeone", email: "toolazytomakeone@gmail.com")

    proc {login(@merchant, :github)}.must_change 'Merchant.count', +1
    must_redirect_to root_path

    session[:merchant_id].must_equal Merchant.find_by(username: "toolazytomakeone").id
  end

  it "clears the session and redirects back to the root path when a merchant logs out" do
    @merchant = merchants(:sappy1)
    login(@merchant, :github)
    post logout_path
    session[:merchant_id].must_equal nil
    must_redirect_to root_path
  end

  it "notifies ther merchant after it logs out" do
    @merchant = merchants(:sappy1)
    login(@merchant, :github)
    post logout_path
    flash[:status].must_equal :success
    flash[:result_text].must_equal "Successfully logged out"
  end





end
