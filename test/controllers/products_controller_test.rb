require "test_helper"

describe ProductsController do
  it "should get index" do
    get products_index_url
    value(response).must_be :success?
  end

  it "should get show" do
    get products_show_url
    value(response).must_be :success?
  end

  it "should get edit" do
    get products_edit_url
    value(response).must_be :success?
  end

  it "should get update" do
    get products_update_url
    value(response).must_be :success?
  end

  it "should get new" do
    get products_new_url
    value(response).must_be :success?
  end

  it "should get create" do
    get products_create_url
    value(response).must_be :success?
  end

  it "should get destroy" do
    get products_destroy_url
    value(response).must_be :success?
  end

end
