require "test_helper"

describe BillingDataController do
  it "should get index" do
    get billing_data_index_url
    value(response).must_be :success?
  end

  it "should get show" do
    get billing_data_show_url
    value(response).must_be :success?
  end

  it "should get edit" do
    get billing_data_edit_url
    value(response).must_be :success?
  end

  it "should get update" do
    get billing_data_update_url
    value(response).must_be :success?
  end

  it "should get new" do
    get billing_data_new_url
    value(response).must_be :success?
  end

  it "should get create" do
    get billing_data_create_url
    value(response).must_be :success?
  end

  it "should get destroy" do
    get billing_data_destroy_url
    value(response).must_be :success?
  end

end
