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

    # it "responds with 404 for non-existing product" do
    #   get product_path(Product.last.id + 1)
    #   must_respond_with :bad_request
    # end


    describe "edit" do
      it "produces an edit form" do


      end
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
    end
  end

  # it "should get edit" do
  #   get products_edit_url
  #   value(response).must_be :success?
  # end
  #
  # it "should get update" do
  #   get products_update_url
  #   value(response).must_be :success?
  # end
  #
  # it "should get new" do
  #   get products_new_url
  #   value(response).must_be :success?
  # end
  #
  # it "should get create" do
  #   get products_create_url
  #   value(response).must_be :success?
  # end
  #
  # it "should get destroy" do
  #   get products_destroy_url
  #   value(response).must_be :success?
  # end

end
