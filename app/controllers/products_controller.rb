class ProductsController < ApplicationController
before_action :find_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.get_products(a_category: params[:category], a_merchant: params[:merchant])

    @categories = Product.categories

  end

  def show
    unless @product
      redirect_to root_path
    end
  end

  def edit
    unless @product
      redirect_to root_path
    end
    unless session[:merchant_id] = @product.merchant.id
      flash[:status] = :error
      flash[:result_text] = "Unauthorized user"
      redirect_to root_path
    end
  end

  def update
  end

  def new
  end

  def create
  end

  private

  def find_product
    @product = Product.find_by_id(params[:id])
  end

end
