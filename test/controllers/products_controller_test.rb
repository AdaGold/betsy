require "test_helper"

describe ProductsController do
  it "must get the index view" do
    get products_path
    must_respond_with :success
  end
end
