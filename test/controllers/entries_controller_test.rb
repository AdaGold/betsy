require "test_helper"

describe EntriesController do
  it "should get index" do
    get entries_index_url
    value(response).must_be :success?
  end

  it "should get show" do
    get entries_show_url
    value(response).must_be :success?
  end

  it "should get edit" do
    get entries_edit_url
    value(response).must_be :success?
  end

  it "should get update" do
    get entries_update_url
    value(response).must_be :success?
  end

  it "should get new" do
    get entries_new_url
    value(response).must_be :success?
  end

  it "should get create" do
    get entries_create_url
    value(response).must_be :success?
  end

  it "should get destroy" do
    get entries_destroy_url
    value(response).must_be :success?
  end

end
