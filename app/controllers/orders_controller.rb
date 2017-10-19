class OrdersController < ApplicationController
  before_action :find_orderitem, only: [:add_item, :update_quantity]
  before_action :find_cart, only: [:show_cart, :update_quantity]

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
    unless @cart
      flash[:status] = :error
      flash[:result_text] = "Invalid order information"
      redirect_to root_path, status: 404
    end
  end

  def show_cart
  end

  def add_item
    product = Product.find_by(id: params[:product_id])
    if product
      if product.quantity >= 1
        if @order_item
          @order_item.quantity += 1
        else
          @order_item = Orderitem.new(order_id: session[:order_id], product_id: params[:product_id], quantity: 1)
        end
        if @order_item.save
          flash[:status] = :success
          flash[:result_text] = "1 #{product.name} added to your cart"
          redirect_back(fallback_location: root_path, status: 200)
        else
          flash[:status] = :error
          flash[:result_text] = "Unable to add #{product.name} to your cart"
          redirect_back(fallback_location: root_path)
        end
      else
        flash[:status] = :error
        flash[:result_text] = "#{product.name} is out of stock"
        redirect_back(fallback_location: root_path, status: 400)
      end
    else
      flash[:status] = :error
      flash[:result_text] = "That is not a valid product"
      redirect_back(fallback_location: root_path, status: 400)
    end
  end

  def update_quantity
    if @order_item
      if @order_item.quantity == params[:quantity].to_i
        flash[:status] = :success
        flash[:result_text] = "#{@order_item.product.name} quantity is still #{@order_item.quantity}"
        return redirect_to show_cart_path
      end
      @order_item.quantity = params[:quantity]
      if @order_item.save
        flash.now[:status] = :success
        flash.now[:result_text] = "#{@order_item.product.name} quantity changed to #{params[:quantity]}"
        return render :show_cart, status: 200
      else
        flash.now[:status] = :error
        flash.now[:result_text] = "#{@order_item.product.name} quantity was not changed"
        return render :show_cart, status: 500
      end
    else
      flash[:status] = :error
      flash[:result_text] = "This item is not in your cart"
      return redirect_back(fallback_location: root_path, status: 400)
    end
  end

  private
  def find_orderitem
    @order_item = Orderitem.find_by(order_id: session[:order_id], product_id: params[:product_id])
  end

  def find_cart
    @cart = Order.find_by(id: session[:order_id], status: "pending")
  end
end
