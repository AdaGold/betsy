class OrdersController < ApplicationController
  def index
  end

  def show
    @cart = @pending_order
  end

  def edit
  end

  def update

  end

  def new
  end

  def create

  end

  def checkout
    if mark_items_as_purchased
      flash[:status] = :success
      @pending_order.order_status = :paid
      @pending_order.save
      
      #nexT: mark the entire order as paid (currently only items are marked paid)
    else
      flash[:status] = :error
      flash[:result_text] = "There was an error; you could not be checked out at this time"
      redirect_back(fallback_location: cart_path)
    end
  end

  def purchase
  end

  def destroy
  end

  def add_product
    @cart_entry = OrderProduct.new(product_id: params[:id].to_i, order_id: @pending_order.id)
    if @cart_entry.save
      flash[:status] = :success
      flash[:result_text] = "Successfully added to your cart!"
      redirect_to order_path(@pending_order)
      redirect_to product_path(params[:id])
    else
      flash[:result_text] = "Could not add that product to your cart"
      flash[:messages] = @cart_entry.errors
      redirect_to root_path
    end
  end


  private
  def cart_entry_params
    # params.require(:product).permit(:id, :name, :description, :price, :user)
  end

  def mark_items_as_purchased
    entries = @pending_order.order_products
    order_id = @pending_order.id
    items_for_purchase = []

    entries.each do |entry|
      if !(entry.valid?)
        flash[:status] = :error
        flash[:result_text] = "Check your cart, inventory has changed."
        flash[:messages] = entry.errors
        # redirect_to cart_path
        return
      end
      quantity = entry.quantity
      available_items = entry.product.available_items

      quantity.times do
        items_for_purchase << available_items.pop
      end
    end

    items_for_purchase.each {|item| item.purchase(order_id)}


    items_for_purchase.each do |item|

      if item.save
        flash[:result_text] = "Items were saved."
      else
        flash[:status] = :error
        flash[:result_text] << "Items were not saved.  Please contact web administrator.   "
        flash[:messages] = "There were errors"
        # item.errors
        # redirect_to cart_path
      end

    end
  end
end
