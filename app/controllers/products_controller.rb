class ProductsController < ApplicationController
before_action :find_product, only: [:show, :edit, :update, :destroy]

before_action :find_merchant

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
      return redirect_to root_path
    end
    unless @merchant == @product.merchant
      flash[:status] = :error
      flash[:result_text] = "Unauthorized user"
      return redirect_to root_path
    end
    @categories = Product.categories
  end

  def update
    unless @product
      flash[:status] = :error
      flash[:result_text] = "That is not a valid product"
      return redirect_to root_path
    end

    unless @merchant == @product.merchant
      flash[:status] = :error
      flash[:result_text] = "Unauthorized user"
      return redirect_to root_path
    end

    if params[:categories]
      params[:categories].each do |category|
        unless @product.categories.include?(category)
          @product.categories << category
        end
      end
    end

    if params[:category]
      unless @product.categories.include?(params[:category])
        @product.categories << params[:category]
      end
    end

    if @product.save
      flash[:status] = :success
      flash[:result_text] = "#{@product.name} updated."
      redirect_to product_path(@product.id), status: 200
    else
      flash[:status] = :error
      redirect_to edit_product_path(@product.id)
    end
  end

  def new
  end

  def create
  end

  private

  def find_product
    @product = Product.find_by_id(params[:id])
  end

  def find_merchant
    @merchant = Merchant.find_by(id: session[:merchant_id])
  end

end
