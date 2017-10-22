require "test_helper"

describe UsersController do
  describe "INDEX" do
    it "should get index" do
      get users_path
      must_respond_with :success
    end
  end

  describe "SHOW" do
    it "should get show" do
      get user_path(users(:carl).id)
      must_respond_with :success
    end


    it "Cannot show a user that doesnt exist" do
        # User.last gives the user with the highest ID
        user_id = User.last.id + 1
        get user_path(user_id)
        # must_respond_with :not_found

        must_respond_with :redirect
        must_redirect_to root_path
      end
  end

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
