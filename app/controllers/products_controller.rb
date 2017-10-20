class ProductsController < ApplicationController
  before_action :find_product, except: [:index, :new, :create]
  def index
    @products = Product.all
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
    @product = Product.new(product_params)
    if @product.save
      flash[:status] = :success
      flash[:result_text] = "Successfully created product #{@product.id} #{@product.name}"
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

private
  def product_params
    params.require(:product).permit(:name, :description, :user_id, :price, :category_id)
  end

  def find_product
    @product = Product.find(params[:id].to_i)
  end
end
