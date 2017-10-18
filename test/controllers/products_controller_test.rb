require "test_helper"

describe ProductsController do
  let(:one) {products(:tree1)}

  describe "index" do
    it "must get the index view" do
      get products_path
      must_respond_with :success
    end

    it "must respond with success with valid filter parameters" do
      #valid category
      get products_path, params: {category: one.category}
      must_respond_with :success
      #valid merchant
      get products_path, params: {merchant: one.merchant.id}
      must_respond_with :success
      #valid category and merchant
      get products_path, params: {category: one.category, merchant: one.merchant.id}
      must_respond_with :success
    end

    it "must respond with a 404 (400?) if any filter parameters are invalid" do
      skip
    end
  end

  it "must get the show view" do
    get product_path(one.id)
    must_respond_with :success

    get product_path(-1)
    must_respond_with :redirect
    must_redirect_to root_path
  end
end
