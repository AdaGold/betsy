require "test_helper"

describe OrdersController do
  #TODO: Add testing for orderscontroller methods
  describe '#show_cart' do
    it "gets the show_cart page with a valid session[:order_id]" do
      skip
    end

    it "does not get the show_cart page with an invalid session[:order_id]" do
      skip
    end
  end

  describe '#add_item' do
    
  end

  describe '#update_quantity' do

  end
  # it "should get index" do
  #   get orders_index_url
  #   value(response).must_be :success?
  # end
  #
  # it "should get create" do
  #   get orders_create_url
  #   value(response).must_be :success?
  # end
  #
  # it "should get new" do
  #   get orders_new_url
  #   value(response).must_be :success?
  # end
  #
  # it "should get edit" do
  #   get orders_edit_url
  #   value(response).must_be :success?
  # end
  #
  # it "should get update" do
  #   get orders_update_url
  #   value(response).must_be :success?
  # end
  #
  # it "should get show" do
  #   get orders_show_url
  #   value(response).must_be :success?
  # end

end
