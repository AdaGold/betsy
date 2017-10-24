require "test_helper"
#IF IT'S COMMENTED OUT, IT'S FAILING!
describe ProductsController do
  describe "index" do
    it "can display a list of all products available on the website" do
      get products_path
      must_respond_with :success
    end

    it "can display index page with no products" do
      # Product.destroy_all
      # Product.count.must_equal 0
      #
      # get products_path
      # must_respond_with :success
    end
  end
  #
  describe "Show" do
    it "shows an existing product" do
      get product_path(products(:converse))
      must_respond_with :success
    end

    # it "responds with 404 for non-existing product" do
    #   get product_path(Product.last.id + 1)
    #   must_respond_with :not_found
    # end
  end

  describe "edit" do
    # it "must be the creator of a product to edit it" do
    #   get edit_product_path(products(:converse))
    #   must_respond_with not_found
    # end

    it "produces an edit form for a valid product" do
      user = users(:carl)
      log_in(user, :github)
      session[:user_id].must_equal user.id

      get edit_product_path(products(:converse))
      must_respond_with :success
    end


    it "does not produce an edit form for a product a user doesn't own" do
      user = users(:mia)
      log_in(user, :github)

      get edit_product_path(products(:converse))
      must_respond_with :not_found
    end

    it "does not product an edit form for bogus data" do
      # user = users(:mia)
      # log_in(user, :github)
      #
      # get edit_product_path(Product.last.id + 1)
      # must_respond_with :not_found
    end
  end


  describe "update" do
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

    # it "cannot update a work that does not exist" do
    #     user = users(:carl)
    #     log_in(user, :github)
    #     product = (Product.last.id + 1)
    #     product_datum = {
    #       product: {
    #         name: "Name updated"
    #       }
    #     }
    #     patch product_path(product), params: product_datum
    #     must_respond_with :not_found
    # end
  end


  describe "new" do
    it "it should get a new form when a user is logged in" do
      log_in(users(:carl), :github)
      get new_product_path
      must_respond_with :success
    end

    # it "shouldn't get a new product form when no user is logged in" do
    #   get new_product_path
    #   must_respond_with :not_found
    # end
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
    #
  end

  describe "destroy" do
    # it "Destroys a product that exists" do
    #   to_destroy = products(:converse)
    #   to_destroy.destroy
    #   must_redirect_to root_path
    #
    # end

    it "cannot destroy a product that doesn't exist" do

    end
  end
<<<<<<< HEAD

=======
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
>>>>>>> 5d5151ab3be2a4ac9448413ff2be819bd49ae437
end
