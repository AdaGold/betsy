class ProductsController < ApplicationController
before_action :find_product, only: [:show, :edit, :update]
before_action :find_merchant, except: [:index, :destroy]
before_action :get_categories, only: [:index, :edit, :new]

  def index
    @products = Product.get_products(a_category: params[:category], a_merchant: params[:merchant])
  end

  def show
  end

  def edit
    unless @merchant == @product.merchant
      flash[:status] = :error
      flash[:result_text] = "Unauthorized user"
      return redirect_to root_path
    end
  end

  def update
    unless @merchant == @product.merchant
      flash[:status] = :error
      flash[:result_text] = "Unauthorized user"
      return redirect_to root_path
    end

    @product.update_attributes(product_params)
    update_categories

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
    unless @merchant
      flash[:status] = :error
      flash[:result_text] = "You need to be logged in to edit or create a product!"
      redirect_back fallback_location: root_path, status: 403
    end

    @product = Product.new(merchant_id: session[:merchant_id])
  end

  def create
    unless @merchant
      flash[:status] = :error
      flash[:result_text] = "You need to be logged in to create a product!"
      return redirect_back fallback_location: root_path, status: 403
    end

    @product = Product.new(product_params)

    update_categories

    if @product.save
      return redirect_to product_path(@product.id)
    else
      flash[:status] = :error
      flash[:result_text] = "Product failed to be added"
      flash[:messages] = @product.errors.messages
      return redirect_to new_product_path
    end
  end

  private

  def find_product
    @product = Product.find_by_id(params[:id])
    render_404 unless @product
  end

  def product_params
    return params.permit(:name, :price, :merchant_id, :quantity, :description, :photo_url)
  end

  def find_merchant
    @merchant = Merchant.find_by(id: session[:merchant_id])
  end

  def get_categories
    @categories = Product.categories
  end

  def update_categories
    if params[:categories]
      params[:categories].each do |category|
        @product.add_category(category)
      end
    end

    if params[:category]
      @product.add_category(params[:category])
    end
  end

end
