class OrdersController < ApplicationController
  before_action :find_orderitem, only: [:add_item, :update_quantity, :remove_from_cart]
  before_action :find_cart, only: [:show_cart, :update_quantity, :remove_from_cart, :checkout]
  after_action :assign_order, only: [:checkout]
  before_action :find_order, only: [:confirmation]

  def index
  end

  def create
  end

  def checkout_form
  end

  def checkout
    puts params
    #verify everything is in stock
    @cart.orderitems.each do |orderitem|
      if orderitem.product.quantity == 0
        flash[:status] = :error
        flash[:result_text] = "#{orderitem.product.name} is out of stock"
        return redirect_to show_cart_path
      elsif orderitem.quantity > orderitem.product.quantity
        flash[:status] = :error
        flash[:result_text] = "You attempted to purchase #{orderitem.quantity} #{orderitem.product.name}, but there are only #{orderitem.product.quantity} available."
        return redirect_to show_cart_path
      end
    end
    #validate user input

    #modify the cart
    @cart.status = "paid"
    @cart.update_attributes(checkout_params)
    #checkout the cart
    if @cart.save
      @cart.orderitems.each do |orderitem|
        product = orderitem.product
        product.quantity -= orderitem.quantity
        product.save
      end

      session[:order_id] = nil
      flash[:status] = :success
      flash[:result_text] = "Your order has been placed"
      return redirect_to order_confirmation_path(@cart.id)
    else
      flash[:status] = :error
      flash[:result_text] = "Your order could not be placed at this time"
      return redirect_to show_cart_path
    end

  end #checkout

  def confirmation
    @total = @order.orderitems.sum { |orderitem| (orderitem.quantity * orderitem.product.price) }
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
      if params[:quantity].to_i <= @order_item.product.quantity
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
        flash.now[:status] = :error
        flash.now[:result_text] = "You can only order up to #{@order_item.product.quantity} of #{@order_item.product.name}"
        return render :show_cart, status: 400
      end
    else
      flash[:status] = :error
      flash[:result_text] = "This item is not in your cart"
      return redirect_back(fallback_location: root_path, status: 400)
    end
  end

  def remove_from_cart
    if @cart
      if @order_item
        if @order_item.destroy
          flash[:status] = :success
          flash[:result_text] = "#{@order_item.product.name} was removed from your cart"
          redirect_back(fallback_location: show_cart_path)
        else
          flash[:status] = :error
          flash[:result_text] = "#{@order_item.product.name} was not removed from your cart"
          redirect_back(fallback_location: show_cart_path)
        end
      else
        flash[:status] = :error
        flash[:result_text] = "This item is not in your cart"
        return redirect_back(fallback_location: show_cart_path)
      end
    else
      flash[:status] = :error
      flash[:result_text] = "Invalid shopping cart"
      return redirect_back(fallback_location: show_cart_path)
    end
  end

  private
  def find_orderitem
    @order_item = Orderitem.find_by(order_id: session[:order_id], product_id: params[:product_id])
  end

  def find_cart
    @cart = Order.find_by(id: session[:order_id], status: "pending")
  end

  def find_order
    @order = Order.find_by(id: params[:id])
  end

  def checkout_params
    params.permit(:customer_email, :address1, :address2, :city, :state, :zipcode, :cc_name, :cc_number, :cc_expiration, :cc_security, :billingzip)
  end
end
