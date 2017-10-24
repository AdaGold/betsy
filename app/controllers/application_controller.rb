class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :find_user
  before_action :find_cart


  #
  # def render_404
  #   raise ActionController::RoutingError.new('Not Found')
  # end



  private
  def find_user
    if session[:user_id]
      @user = User.find_by(id: session[:user_id])
    end
  end

  def find_cart
    if @user
      @pending_order = @user.find_pending_order
      if !(@pending_order)
        @pending_order = Order.find_by(session_id: session[:session_id])
        @pending_order.user_id = @user.id
        @pending_order.save
      end
    else
      if !(@pending_order)
        new_pending_order(session[:session_id]) #creates a new pending_order with current session_id and nil user id
      end
    end
    session[:pending_order_id] = @pending_order.id
  end

  def new_pending_order(input_session_id, input_user_id = nil)
    @pending_order = Order.new
    @pending_order.session_id = input_session_id
    @pending_order.user_id = input_user_id
    @pending_order.save
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
    redirect_to root_path
  end
end
