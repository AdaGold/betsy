require "test_helper"

describe ProductsController do
  describe "index" do
    it "can display a list of all products available on the website" do
      get products_path
      must_respond_with :success
    end

    it "can display index page with no products" do
      Product.destroy_all
      Product.count.must_equal 0

      get products_path
      must_respond_with :success
    end
  end

  describe "Show" do
    it "shows an existing product" do
      get product_path(products(:converse))
      must_respond_with :success
    end

    it "users cannot leave reviews for their products" do
      user = users(:carl)
      log_in(user, :github)

      get product_path(products(:converse).id)

      controller.instance_variable_get("@current_user_is_not_product_owner").must_equal false

    end

    # it "responds with 404 for non-existing product" do
    #   get product_path(Product.last.id + 1)
    #   must_respond_with :bad_request
    # end


    describe "edit" do
      it "produces an edit form for a valid product" do
        get edit_product_path(products(:converse))
        must_respond_with :success
      end

      # it "does not produce an edit form for bogus product" do
      #   get edit_product_path(Product.last.id+1)
      #   must_respond_with :not_found
      # end
    end

    describe "update" do
      it "can update an existing work with valid data" do
        product = products(:converse)
        product_datum = {
          product: {
            name: product.name + " updated"
          }
        }
        patch product_path(product), params: product_datum
      end
      #
      # it "cannot update a work that does not exist" do
      #     product = Product.last.id + 1
      #     product_datum = {
      #       product: {
      #         name: product.name + " updated"
      #       }
      #     }
      #     patch product_path(product), params: product_datum
      #     must_respond_with :not_found
      # end
    end

    describe "new" do
      it "it should get a new form" do
        get new_product_path
        must_respond_with :success
      end
    end

    describe "create" do
      it "should create a new product when given valid data" do
        user = users(:carl).id
        product_data = {
          product: {
            name: "God Ugly Converse",
            price: 99,
            description: "Great pink shoes!",
            user_id: user
          }
        }
        post products_path, params: product_data
        must_respond_with :success
      end

      it "should throw an error when not given valid data" do
        user = users(:carl).id
        product_data = {
          product: {
            name: "God Ugly Converse",
            price: 99,
            user_id: user
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

    end

    describe "destroy" do
      it "Destroys a product that exists" do
        to_destroy = products(:converse)
        to_destroy.destroy
        must_redirect_to root_path

      end

      it "cannot destroy a product that doesn't exist" do

      end

    end
  end
end
