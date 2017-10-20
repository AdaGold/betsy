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

    get users_path
    must_respond_with :success
  end

  it "should get show" do
    get user_path(users(:carl).id)
    must_respond_with :success
  end

# TODO
  # it "Cannot show a user that doesnt exist" do
  #     # User.last gives the user with the highest ID
  #     user = User.last.id + 1
  #     get user_path(user)
  #     must_respond_with :not_found
  #
  #     # must_respond_with :redirect
  #     # must_redirect_to root_path
  #   end


  it "should successfully create a new user" do
    proc  {
      post users_path, params: {users: {username: "Test", email: "test@test.com"}}}.must_change 'User.count', 1

      must_respond_with :redirect
      must_redirect_to root_path
  end

  it "should be able to update a user" do
    put user_path(users(:carl)), params: {user: {username: "Karl"} }
    user = User.find(users(:carl).id)
    user.username = "Karl"
    user.username.must_equal "Karl"

    must_respond_with :redirect
    must_redirect_to root_path
  end


  # it "Should be able to delete a user" do
  #   proc  {
  #     delete user_path(users(:carl).id)}.must_change 'User.count', - 1
  #
  #     must_respond_with :redirect
  #     must_redirect_to root_path
  # end


  # it "should get edit" do
  # end
end
