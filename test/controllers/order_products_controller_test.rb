require "test_helper"

describe OrderProductsController do
  # let(:entry) = {order_products(:mias_pending_products) }
  describe "destroy" do
    it "should succeeed for an extant Order Product" do
      user = users(:mia)
      log_in(user, :github)
      get root_path
      get cart_path
      entry = order_products(:mias_pending_products).id
      delete order_product_path(entry)
      must_respond_with :redirect
    end


  end
end
