class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :find_user
  before_action :find_cart
  before_action :make_guest_cart
  before_action :set_session_to_cart


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

  def make_guest_cart
    if !(session[:user_id]) && !(session[:pending_order_id])
      # @pending_order = Order.new
      # @pending_order.session_id = session[:session_id]
      # session[:pending_order_id] = @pending_order_id if @pending_order.save
    end
  end

  def find_cart
    if @user #find auth_user cart
      @pending_order = @user.find_pending_order
      session[:pending_order_id] = @pending_order.id if @pending_order
      if !(@pending_order) #make them one if they don't have
        @pending_order = Order.find_by(session_id: session[:session_id])
        @pending_order.user_id = @user.id
        @pending_order.save
        session[:pending_order_id] = @pending_order.id
      end
    else
      if session[:pending_order_id] #find guest's current cart
        @pending_order = Order.find(session[:pending_order_id])
      else #make them one if they don't have
        # @pending_order = new_pending_order(session[:session_id], nil)
        @pending_order = Order.new
        @pending_order.session_id = "guest_user"
        # binding.pry
        @pending_order.save
        session[:pending_order_id] = @pending_order.id
      end
    end

  end
  def set_session_to_cart
    @pending_order.session_id = session[:session_id]
    @pending_order.save
  end

  def new_pending_order(input_session_id, input_user_id)
    new_order = Order.new
    new_order.session_id = input_session_id
    new_order.user_id = input_user_id
    return new_order
  end


end
