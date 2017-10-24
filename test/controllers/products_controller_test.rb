require "test_helper"
#IF IT'S COMMENTED OUT, IT'S FAILING!
describe ProductsController do
  describe "index" do
    it "can display a list of all products available on the website" do
      get products_path
      must_respond_with :success
    end

    it "can display index page with no products" do
      #not destroying products!
      OrderProduct.destroy_all
      OrderProduct.count.must_equal 0

      Item.destroy_all
      Item.count.must_equal 0

      Product.destroy_all
      Product.count.must_equal 0

      get products_path
      must_respond_with :success
    end

    #
    describe "Show" do
      it "shows an existing product" do
        get product_path(products(:converse))
        must_respond_with :success
      end

      #
      it "responds with 404 for non-existing product" do
        get product_path(Product.last.id + 1)
        must_respond_with :not_found
      end
    end
    #
    describe "edit" do
      it "logged in owner can see an edit form for their product " do
        user = users(:carl)
        log_in(user, :github)
        session[:user_id].must_equal user.id

        get edit_product_path(products(:converse))
        must_respond_with :success
      end

      it "must be the creator of a product to edit it" do
        get edit_product_path(products(:converse))
        must_respond_with :not_found
      end

      it "does not produce an edit form for a product a user doesn't own" do
        user = users(:mia)
        log_in(user, :github)

        get edit_product_path(products(:converse))
        must_respond_with :not_found
      end


      it "does not produce an edit form for bogus data" do
        user = users(:carl)
        log_in(user, :github)
        nonexistant_data = Product.last.id + 1

        get edit_product_path(nonexistant_data)
        must_respond_with :not_found
      end
    end


    describe "update" do
      it "a product cannot be updated, except by the owner" do
        product = products(:converse)
        product_datum = {
          product: {
            name: product.name + " updated"
          }
        }
        patch product_path(product), params: product_datum
        must_respond_with :not_found
      end

      it "can update an existing work with valid data" do
        user = users(:carl)
        log_in(user, :github)
        product = products(:converse)
        product_datum = {
          product: {
            name: product.name + " updated"
          }
        }
        patch product_path(product), params: product_datum
      end

      it "cannot update a work that does not exist" do
        user = users(:carl)
        log_in(user, :github)
        product = (Product.last.id + 1)
        product_datum = {
          product: {
            name: "Name updated"
          }
        }
        patch product_path(product), params: product_datum
        must_respond_with :not_found
      end
    end

    describe "new" do
      it "it should get a new form when a user is logged in" do
        log_in(users(:carl), :github)
        get new_product_path
        must_respond_with :success
      end

      it "shouldn't get a new product form when no user is logged in" do
        get new_product_path
        must_respond_with 404
      end
    end

    describe "create" do
      it "should create a new product when given valid data" do
        user = users(:carl)
        log_in(user, :github)

        product_data = {
          product: {
            name: "God Ugly Converse",
            price: 99,
            description: "Great pink shoes!",
            user_id: user.id
          }
        }
        post products_path, params: product_data
        must_respond_with :redirect
        must_redirect_to profile_path(user)
      end

      it "should throw an error when not given valid data" do
        user = users(:carl)
        log_in(user, :github)
        product_data = {
          product: {
            name: "God Ugly Converse",
            price: 99,
            user_id: user.id
          }
        }


        nil_product = product_data.deep_dup

        product_data[:product].each do |key, value|
          nil_product = product_data.deep_dup
          nil_product[:product][key] = nil
          post products_path, params: nil_product
          must_respond_with :bad_request
        end
      end

      it "should throw 404 when no user is logged in" do
        user = users(:carl)
        product_data = {
          product: {
            name: "God Ugly Converse",
            price: 99,
            description: "Great pink shoes!",
            user_id: user.id
          }
        }
        post products_path, params: product_data
        must_respond_with :not_found
      end
    end

    describe "change_visibility" do
      it "allows a user to change the visibility of a product they own" do
        user = users(:carl)
        log_in(user, :github)
        get root_path
        product = products(:flats)

        product.visibility.must_equal true
        post change_visibility_path(product.id)
        product.visibility.must_equal false
      end
    end


    describe "add_to_order" do
      it "should change number of order products" do
        user = users(:mia)
        product = products(:converse)
        log_in(user, :github)

        get product_path(product.id)
        proc {
          post product_path(product.id), params: {quantity: "3"}
        }.must_change 'OrderProduct.count', 1
      end

      it "should add an orderproduct to current pending order for auth user" do
        user = users(:mia)
        product = products(:converse)
        quantity_data = {
          quantity: "5"
        }

        start_count = OrderProduct.count
        # pending_order = orders(:mias_pending_order)

        log_in(user, :github)

        get product_path(product.id)
        pending_order = Order.find(session[:pending_order_id])
        # session[:pending_order_id].must_equal pending_order.id

        post product_path(product.id), params: quantity_data


        OrderProduct.count.must_equal (start_count + 1)
        pending_order.order_products.length.must_equal 2

        pending_order.order_products.each do |entry|
          entry.product_id.must_equal product.id
          entry.order_id.must_equal pending_order.id
        end
      end

    end
  end
end
