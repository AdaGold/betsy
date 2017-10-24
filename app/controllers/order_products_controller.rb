class OrderProductsController < ApplicationController
  def create
    @cart_entry = OrderProduct.new(product_id: params[:id], order_id: @pending_order)
    if @cart_entry.save
      flash[:status] = :success
      flash[:result_text] = "Successfully added this to your cart!"
      redirect_to order_path(@pending_order)
      # redirect_to product_path(params[:id])
    end
  end

  def update
    sent_params = params
    find_entry
    if !@entry
      render_404
      return
    end
    old_quantity = @entry.quantity
    sent_quantity = params[:order_product][:quantity].to_i
    if sent_quantity == 0
      flash[:result_text] = "Could not update #{@entry.product.name}.  Make sure you are entering a number greater than 0.  If you wanted to delete it, click delete from cart."
      flash[:status] = :error
      redirect_to cart_path
      return
    end
    @entry.quantity = sent_quantity
    new_quantity = @entry.quantity
    if @entry.save
      flash[:status] = :success
      flash[:result_text] = "Successfully updated #{@entry.product.name} from #{old_quantity} to #{new_quantity}!  The params were #{sent_params} "
      # redirect_to order_path(@pending_order)
      redirect_to cart_path
    else
      flash[:result_text] = "Could not update #{@entry.product.name}.  Please check errors."
      flash[:messages] = @entry.errors
      redirect_to cart_path
    end
  end

  def destroy
    find_entry
    if !@entry
      render_404
      return
    end
    deleted_entry = "#{@entry.product.name}"
    if @entry.destroy
      flash[:success] = "Successfully deleted #{deleted_entry}."
      redirect_to order_path(@pending_order.id)
    else

    end
  end


  private
  def cart_entry_params
    # params.require(:product).permit(:id, :name, :description, :price, :user)
  end

  def find_entry
    @entry = OrderProduct.find_by(id: params[:id])
  end
end
