class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :assign_order


  private
  def assign_order
    if session[:order_id] == nil or Order.find_by(id: session[:order_id], status: "pending") == nil
      order = Order.new(status: "pending")
      if order.save
        session[:order_id] = order.id
      else
        redirect_to root_path, status: 500
      end
    end
  end
end
