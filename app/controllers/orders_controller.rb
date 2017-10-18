class OrdersController < ApplicationController
  def index
  end

  def create
  end

  def new
  end

  def edit
  end

  def update
  end

  def show
  end

  def add_item
    order_item = Orderitem.find_by(order_id: session[:order_id], product_id: params[:product_id])
    product = Product.find_by(id: params[:product_id])
    if product
      if product.quantity >= 1
        if order_item
          order_item.quantity += 1
        else
          order_item = Orderitem.new(order_id: session[:order_id], product_id: params[:product_id], quantity: 1)
        end
        product.quantity -= 1
        if order_item.save && product.save
          #TODO: put in a success flash message once we decide what format we want to use
          redirect_back(fallback_location: root_path)
        else
          #TODO: put in a failure flash message once we decide what format we want to use
        end
      else
        #TODO: put in a failure flash message for out of stock product
      end
    else
      #TODO: put in a failure flash message for invalid product
    end
  end
end
