require "test_helper"

describe OrdersController do
  let(:product) {products(:tree1)}

  describe '#show_cart' do
    it "gets the show_cart page with a valid session[:order_id]" do
      get show_cart_path
      session[:order_id].wont_equal nil
      must_respond_with :success
    end

    it "gets the show_cart page with an invalid session[:order_id] once the session[:order_id] has been automatically reset to a valid valu]e" do
      invalid_id = -1
      get show_cart_path
      session[:order_id] = invalid_id
      get show_cart_path
      must_respond_with :success
      session[:order_id].wont_equal invalid_id
    end
  end

  describe '#add_item' do
    before do
      get root_path #do this to get session
    end
    it "won't add item if the product is invalid" do
      invalid_id = -1
      patch add_order_item_path(session[:order_id], invalid_id)
      must_respond_with :bad_request
      flash[:status].must_equal :error
      flash[:result_text].must_equal "That is not a valid product"
    end

    it "won't add item if the product quantity is < 1" do
      product.quantity = 0
      product.save.must_equal true
      patch add_order_item_path(session[:order_id], product.id)
      must_respond_with :bad_request
      flash[:status].must_equal :error
      flash[:result_text].must_equal "#{product.name} is out of stock"
    end

    it "will add the item if the product is valid and the product quantity is > 0" do
      patch add_order_item_path(session[:order_id], product.id)
      must_respond_with :success
      flash[:status].must_equal :success
      flash[:result_text].must_equal "1 #{product.name} added to your cart"
    end

    it "will update the quantity of the item in cart if already added before" do
      product.quantity = 2
      product.save.must_equal true
      #adding first time
      patch add_order_item_path(session[:order_id], product.id)
      must_respond_with :success
      flash[:status].must_equal :success
      flash[:result_text].must_equal "1 #{product.name} added to your cart"
      order_item = Order.find_by(id: session[:order_id]).orderitems.first
      order_item.product_id.must_equal product.id
      order_item.quantity.must_equal 1
      #adding second time
      patch add_order_item_path(session[:order_id], product.id)
      must_respond_with :success
      flash[:status].must_equal :success
      flash[:result_text].must_equal "1 #{product.name} added to your cart"
      order_item = Order.find_by(id: session[:order_id]).orderitems.first
      order_item.product_id.must_equal product.id
      order_item.quantity.must_equal 2
    end
  end

  describe '#update_quantity' do
    it "won't allow action if item is not in cart" do
      skip
    end

    it "will redirect back with a flash message if the quantity is not changed" do
      skip
    end

    it "won't allow the quantity to be changed to < 1" do
      skip
    end

    it "won't allow the quantity to be changed to > product quantity" do
      skip
    end

    it "will update the quantity of an item that is in the cart" do
      skip
    end
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
