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
      must_respond_with :redirect
      flash[:status].must_equal :error
      flash[:result_text].must_equal "That is not a valid product"
    end

    it "won't add item if the product quantity is < 1" do
      product.quantity = 0
      product.save.must_equal true
      patch add_order_item_path(session[:order_id], product.id)
      must_respond_with :redirect
      flash[:status].must_equal :error
      flash[:result_text].must_equal "#{product.name} is out of stock"
    end

    it "will add the item if the product is valid and the product quantity is > 0" do
      patch add_order_item_path(session[:order_id], product.id)
      must_respond_with :redirect
      flash[:status].must_equal :success
      flash[:result_text].must_equal "1 #{product.name} added to your cart"
    end

    it "will update the quantity of the item in cart if already added before" do
      product.quantity = 2
      product.save.must_equal true
      #adding first time
      patch add_order_item_path(session[:order_id], product.id)
      must_respond_with :redirect
      flash[:status].must_equal :success
      flash[:result_text].must_equal "1 #{product.name} added to your cart"
      order_item = Order.find_by(id: session[:order_id]).orderitems.first
      order_item.product_id.must_equal product.id
      order_item.quantity.must_equal 1
      #adding second time
      patch add_order_item_path(session[:order_id], product.id)
      must_respond_with :redirect
      flash[:status].must_equal :success
      flash[:result_text].must_equal "1 #{product.name} added to your cart"
      order_item = Order.find_by(id: session[:order_id]).orderitems.first
      order_item.product_id.must_equal product.id
      order_item.quantity.must_equal 2
    end
  end

  describe '#update_quantity' do
    before do
      get root_path #do this to get session
      Order.find_by(id: session[:order_id]).orderitems.count.must_equal 0
      #add product to cart
      patch add_order_item_path(session[:order_id], product.id)
      must_respond_with :redirect
      flash[:result_text].must_equal "1 #{product.name} added to your cart"
      order_item = Order.find_by(id: session[:order_id]).orderitems.first
      order_item.product_id.must_equal product.id
      order_item.quantity.must_equal 1
    end

    it "won't allow action if item is not in cart" do
      invalid_id = -1
      patch update_quantity_path(session[:order_id], invalid_id)
      must_respond_with :redirect
      flash[:status].must_equal :error
      flash[:result_text].must_equal "This item is not in your cart"
    end

    it "will redirect back with a flash message if the quantity is not changed" do
      patch update_quantity_path(session[:order_id], product.id), params: {quantity: 1}
      must_respond_with :redirect
      must_redirect_to show_cart_path
      flash[:status].must_equal :success
      flash[:result_text].must_equal "#{product.name} quantity is still 1"
    end

    it "won't allow the quantity to be changed to < 1" do
      patch update_quantity_path(session[:order_id], product.id), params: {quantity: 0}
      must_respond_with :success
      flash[:status].must_equal :error
      flash[:result_text].must_equal "#{product.name} quantity was not changed"
    end

    it "won't allow the quantity to be changed to > product quantity" do
      patch update_quantity_path(session[:order_id], product.id), params: {quantity: (product.quantity + 1)}
      must_respond_with :success
      flash[:status].must_equal :error
      flash[:result_text].must_equal "You can only order up to #{product.quantity} of #{product.name}"
    end

    it "will update the quantity of an item that is in the cart" do
      product.quantity.must_be :>, 1
      patch update_quantity_path(session[:order_id], product.id), params: {quantity: (product.quantity - 1)}
      must_respond_with :success
      flash[:status].must_equal :success
      flash[:result_text].must_equal "#{product.name} quantity changed to #{product.quantity - 1}"
    end
  end

  describe "#remove_from_cart" do
    before do
      get root_path #do this to get session
      Order.find_by(id: session[:order_id]).orderitems.count.must_equal 0
    end

    it "won't remove an item from an invalid cart" do
      skip
    end

    it "won't remove an item if the item doesn't exist in that cart" do
      delete remove_from_cart_path(session[:order_id], product.id)
      must_respond_with :redirect
      flash[:status].must_equal :error
      flash[:result_text].must_equal "This item is not in your cart"
    end

    it "will remove a valid item from a valid cart" do
      #add product to cart
      patch add_order_item_path(session[:order_id], product.id)
      must_respond_with :redirect
      flash[:result_text].must_equal "1 #{product.name} added to your cart"
      order_item = Order.find_by(id: session[:order_id]).orderitems.first
      order_item.product_id.must_equal product.id
      order_item.quantity.must_equal 1
      delete remove_from_cart_path(session[:order_id], product.id)
      must_respond_with :redirect
      flash[:status].must_equal :success
      flash[:result_text].must_equal "#{product.name} was removed from your cart"
    end
  end

  describe "#checkout_form" do

    it "should get the checkout_form" do
      get checkout_form_path
      must_respond_with :success
    end

  end

  describe "#checkout" do

    describe "Reduces the number of inventory for each product" do
      before do
        get root_path #do this to get session
        Order.find_by(id: session[:order_id]).orderitems.count.must_equal 0
        #add product to cart
        patch add_order_item_path(session[:order_id], product.id)
        must_respond_with :redirect
        flash[:result_text].must_equal "1 #{product.name} added to your cart"
        order_item = Order.find_by(id: session[:order_id]).orderitems.first
        order_item.product_id.must_equal product.id
        order_item.quantity.must_equal 1
      end

      it "reduces inventory" do
        patch checkout_path
        Product.find_by(name: product.name).quantity.must_equal product.quantity - 1
        must_respond_with :redirect
      end

      it "won't allow purchase of out of stock items" do
        out_of_stock_product = Product.find_by(name: product.name)
        out_of_stock_product.quantity = 0
        out_of_stock_product.save.must_equal true
        patch checkout_path
        flash[:status].must_equal :error
        flash[:result_text].must_equal "#{product.name} is out of stock"
        must_redirect_to show_cart_path
      end

      it "won't allow purchase of more items than are available" do
        # add a second item to the cart
        patch add_order_item_path(session[:order_id], product.id)
        flash[:result_text].must_equal "1 #{product.name} added to your cart"
        order_item = Order.find_by(id: session[:order_id]).orderitems.first
        order_item.product_id.must_equal product.id
        order_item.quantity.must_equal 2
        # set product quantity to 1
        product.quantity = 1
        product.save.must_equal true
        patch checkout_path
        flash[:status].must_equal :error
        flash[:result_text].must_equal "You attempted to purchase #{order_item.quantity} #{product.name}, but there are only #{product.quantity} available."
        must_redirect_to show_cart_path
      end

    end

    describe "changes the order status and purchase_datetime" do
      before do
        get root_path #do this to get session
        Order.find_by(id: session[:order_id]).orderitems.count.must_equal 0
        #add product to cart
        patch add_order_item_path(session[:order_id], product.id)
        must_respond_with :redirect
        flash[:result_text].must_equal "1 #{product.name} added to your cart"
        order_item = Order.find_by(id: session[:order_id]).orderitems.first
        order_item.product_id.must_equal product.id
        order_item.quantity.must_equal 1
        @order = Order.find_by(id: session[:order_id])
      end

      it "changes the order status from pending to paid" do
        @order.status.must_equal "pending"
        patch checkout_path
        must_respond_with :redirect
        flash[:status].must_equal :success
        flash[:result_text].must_equal "Your order has been placed"
        Order.find_by(id: @order.id).status.must_equal "paid"
      end

      it "changes the purchase_datetime to the datetime the order was placed" do
        @order.purchase_datetime.must_equal nil
        patch checkout_path
        must_respond_with :redirect
        flash[:status].must_equal :success
        flash[:result_text].must_equal "Your order has been placed"
        order_datetime = Order.find_by(id: @order.id).purchase_datetime
        order_datetime.to_date.must_equal Date.today
        order_datetime.must_be :<, DateTime.now
      end
    end

    describe "clears the current cart" do
      before do
        get root_path #do this to get session
        Order.find_by(id: session[:order_id]).orderitems.count.must_equal 0
        #add product to cart
        patch add_order_item_path(session[:order_id], product.id)
        must_respond_with :redirect
        flash[:result_text].must_equal "1 #{product.name} added to your cart"
        order_item = Order.find_by(id: session[:order_id]).orderitems.first
        order_item.product_id.must_equal product.id
        order_item.quantity.must_equal 1
      end

      it "shows that the cart is now empty" do
        patch checkout_path
        order = Order.find_by(id: session[:order_id])
        order.wont_equal nil
        order.orderitems.count.must_equal 0
      end

      it "sets a new session order id when checkout process complete" do
        old_order_id = session[:order_id]
        patch checkout_path
        order = Order.find_by(id: session[:order_id])
        order.id.wont_equal old_order_id
      end

    end

    describe "Properly updates order for user input" do
      before do
        get root_path #do this to get session
        Order.find_by(id: session[:order_id]).orderitems.count.must_equal 0
        #add product to cart
        patch add_order_item_path(session[:order_id], product.id)
        must_respond_with :redirect
        flash[:result_text].must_equal "1 #{product.name} added to your cart"
        order_item = Order.find_by(id: session[:order_id]).orderitems.first
        order_item.product_id.must_equal product.id
        order_item.quantity.must_equal 1
      end

      it "updates fields for user input" do
        order = Order.find_by(id: session[:order_id])
        patch checkout_path, params: {customer_email: "test@test.com", address1: "123 Test Street", address2: "Apt 2", city: "Seattle", state: "WA", zipcode: "98102", cc_name: "Test Name", cc_number: "4111111111111111", cc_expiration: "01/20", cc_security: "012", billingzip: "98101"}
        must_respond_with :redirect
        flash[:status].must_equal :success
        flash[:result_text].must_equal "Your order has been placed"
        paid_order = Order.find_by(id: order.id)
        paid_order.customer_email.must_equal "test@test.com"
        paid_order.address1.must_equal "123 Test Street"
        paid_order.address2.must_equal "Apt 2"
        paid_order.city.must_equal "Seattle"
        paid_order.state.must_equal "WA"
        paid_order.zipcode.must_equal "98102"
        paid_order.cc_name.must_equal "Test Name"
        paid_order.cc_number.must_equal "4111111111111111"
        paid_order.cc_expiration.must_equal "01/20"
        paid_order.cc_security.must_equal "012"
        paid_order.billingzip.must_equal "98101"
      end
      it "validates user input" do
        skip
      end
    end

  end #checkout


end #OrdersController
