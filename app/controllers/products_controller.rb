class ProductsController < ApplicationController
  before_action :find_product, except: [:index, :new, :create]
  def index
    @products = Product.show_available
  end

  def show
    @user = @product.user
    unless @product
      render :not_found
    end
  end

  def edit
  end

  def update
    @product.update_attributes product_params
    if @product.save
      flash[:status] = :success
      flash[:result_text] = "Successfully updated #{@product.name}"
      redirect_to profile_path(@user)
    else
      flash[:status] = :failure
      flash[:result_text] = "Could not update #{@product.name}"
      render :edit, status: :not_found
    end
  end

  def new
    @product = Product.new
  end

  def create
    # as long as this exists: session[:user_id]
    # product_params.user_id = session[:user_id]

    @product = Product.new(product_params)
    if @product.save
      flash[:status] = :success
      flash[:result_text] = "Successfully created product #{@product.id} #{@product.name}"
      redirect_to profile_path(@user)
    else
      flash[:status] = :failure
      flash[:result_text] = "Unable to create a product"
      flash[:messages] = @product.errors.messages
      render :new, status: :bad_request
    end
  end

  def destroy
    @product.destroy
    flash[:status] = :success
    flash[:result_text] = "Successfully destroyed product #{@product.id}, #{@product.name}"
    redirect_to root_path
  end

  def change_visibility
    if @product.visibility == false
      @product.visibility = true
      @product.save
      flash[:result_text] = "Your product is now visible in browsing"
      redirect_back(fallback_location: products_path)
    else
      @product.visibility = false
      @product.save
      flash[:result_text] = "Your product is no longer visibile in browsing"
      redirect_back(fallback_location: products_path)
    end
  end

private
  def product_params
    params.require(:product).permit(:name, :description, :user_id, :price, category_ids:[])
  end

  def find_product
    @product = Product.find(params[:id].to_i)
  end
end
