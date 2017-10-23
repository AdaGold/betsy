# class OrdersProductsController < ApplicationController
#
#   def create
#     @cart_entry = OrderProduct.new(product_id: params[:id], order_id: @pending_order)
#     if @cart_entry.save
#       flash[:status] = :success
#       flash[:result_text] = "Successfully added this to your cart!"
#       redirect_to order_path(@pending_order)
#       # redirect_to product_path(params[:id])
#     end
#   end
#
#
#   private
#   def cart_entry_params
#     # params.require(:product).permit(:id, :name, :description, :price, :user)
#   end
# end
