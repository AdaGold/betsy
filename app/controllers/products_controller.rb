class ProductsController < ApplicationController
before_action :find_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.get_products(a_category: params[:category], a_merchant: params[:merchant])
  end

  def show
    unless @product
      redirect_to root_path
    end
  end

  def edit
  end

  def update
  end

  def new
    unless session[:merchant_id]
      flash[:status] = :error
      flash[:result_text] = "You need to be logged in to create a product!"
       redirect_back fallback_location: root_path, status: 403
    end
    @product = Product.new(merchant_id: session[:merchant_id])
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to product_path(@product.id)
    else
      flash[:status] = :error
      flash[:result_text] = "Product failed to be added"
      flash[:messages] = @product.errors.messages
      redirect_to new_product_path
    end
  end

  private

  def find_product
    @product = Product.find_by_id(params[:id])
  end

  def product_params
    return params.require(:product).permit(:name, :price, :merchant_id, :category, :quantity)
  end

end
