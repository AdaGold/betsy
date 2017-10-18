require "test_helper"

describe UsersController do
  it "should get index" do
    get users_index_url
    value(response).must_be :success?
  end

  it "should get show" do
    get users_show_url
    value(response).must_be :success?
  end

  it "should get create" do
    get users_create_url
    value(response).must_be :success?
  end

  it "should get update" do
    get users_update_url
    value(response).must_be :success?
  end

  it "should get destroy" do
    get users_destroy_url
    value(response).must_be :success?
  end

  it "should get edit" do
    get users_edit_url
    value(response).must_be :success?
  end

  it "should get new" do
    get users_new_url
    value(response).must_be :success?
  end

end
