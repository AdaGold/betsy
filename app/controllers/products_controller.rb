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

    @product.save

    if @product.save
      flash[:status] = :success
      flash[:result_text] = "#{@product.name} updated."
      redirect_to product_path(@product.id)
    else
      flash[:status] = :error
      redirect_to edit_product_path(@product.id)
    end
  end

  def new
    unless session[:merchant_id]
      flash[:status] = :error
      flash[:result_text] = "You need to be logged in to create a product!"
       redirect_back fallback_location: root_path, status: 403
    end

    @product = Product.new(merchant_id: session[:merchant_id])
    @categories = Product.categories
  end

  def create
    @product = Product.new(product_params)

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
    return params.permit(:name, :price, :merchant_id, :quantity)
  end

  def find_merchant
    @merchant = Merchant.find_by(id: session[:merchant_id])
  end

end
