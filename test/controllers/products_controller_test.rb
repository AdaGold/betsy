require "test_helper"

describe ProductsController do
  let(:one) {products(:tree1)}

  it "must get the index view" do
    get products_path
    must_respond_with :success
  end

  it "must get the show view" do
    get product_path(one.id)
    must_respond_with :success

    get product_path(-1)
    must_respond_with :redirect
    must_redirect_to root_path
  end
end
