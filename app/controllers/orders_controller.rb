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

  def destroy
  end

  def add_product
    @cart_entry = OrderProduct.new(product_id: params[:id], order_id: @pending_order)
    if @cart_entry.save
      flash[:status] = :success
      flash[:result_text] = "Successfully added to your cart!"
      redirect_to order_path(@pending_order)
      # redirect_to product_path(params[:id])
    else
      flash[:result_text] = "Could not add that product to your cart"
      flash[:messages] = @cart_entry.errors.message
      redirect_to root_path
    end
  end


  private
  def cart_entry_params
    # params.require(:product).permit(:id, :name, :description, :price, :user)
  end
end
