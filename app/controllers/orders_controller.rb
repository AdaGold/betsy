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
        if order_item.save
          flash[:status] = :success
          flash[:result_text] = "1 #{product.name} added to your cart"
          redirect_back(fallback_location: root_path)
        else
          flash[:status] = :error
          flash[:result_text] = "Unable to add #{product.name} to your cart"
          redirect_back(fallback_location: root_path)
        end
      else
        flash[:status] = :error
        flash[:result_text] = "#{product.name} is out of stock"
        redirect_back(fallback_location: root_path)
      end
    else
      flash[:status] = :error
      flash[:result_text] = "That is not a valid product"
      redirect_back(fallback_location: root_path)
    end
  end
end
