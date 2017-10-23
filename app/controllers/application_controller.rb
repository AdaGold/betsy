class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :assign_order

  def render_404
   render file: "/public/404.html", status: 404
  end

  private
  def assign_order
    if session[:order_id] == nil || Order.find_by(id: session[:order_id], status: "pending") == nil
      order = Order.new(status: "pending")
      if order.save
        session[:order_id] = order.id
      else
        redirect_to root_path, status: 500
      end
    end
  end
end
