require 'test_helper'

describe ApplicationController do
  it "should find an existing user if user is logged in" do
    start_count = User.count
    user = users(:mia)

    log_in(user, :github)

    must_respond_with :redirect
    must_redirect_to root_path
    User.count.must_equal start_count
    session[:user_id].must_equal user.id
  end

  it "should find a pending order for an existing user that is logged in" do
    get root_path
    user = users(:mia)
    guest_cart_id = session[:pending_order_id]
    log_in(user, :github)
    get root_path
    session[:user_id].must_equal  user.id
    session[:pending_order_id].must_be :!=, guest_cart_id
    session[:pending_order_id].must_equal orders(:mias_pending_order).id

  end

  it "should assign pending order from guest session to logged in user if they do not have pending orders" do
    user = users(:sophie_no_pending_order)
    get root_path
    guest_session_id = session[:session_id]
    log_in(user, :github)
    get root_path
    session[:user_id].must_equal user.id
    (Order.find(session[:pending_order_id])).session_id.must_equal guest_session_id
  end


end
