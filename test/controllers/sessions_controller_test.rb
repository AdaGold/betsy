require "test_helper"

describe SessionsController do
  describe "auth_callback" do
  it "should log in an existing user and redirects them back to the homepage" do
    start_count = User.count
    user = users(:carl)

    #Action
    log_in(user, :github)
    #Assert
    must_respond_with :redirect
    must_redirect_to root_path
    User.count.must_equal start_count
    session[:user_id].must_equal user.id
  end

  it "can log in a new user" do
    start_count = User.count
    user = User.new username: "Greg", provider: 'github', email: 'RapMonster@naver.com'
    user.uid = 901
    log_in(user, :github)

    #Assert
    must_respond_with :redirect
    must_redirect_to root_path
    User.count.must_equal (start_count + 1)
    saved_user = User.find_by(username: "Greg")
    session[:user_id].must_equal saved_user.id
  end
end
end
