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

  def add_to_order
    @cart_entry = create_entry(params[:quantity])
    # binding.pry
    if @cart_entry.save
      flash[:status] = :success
      flash[:result_text] = "Successfully added to your cart!"
      # redirect_to order_path(@pending_order)
      redirect_to product_path(@product.id)
    else
      flash[:result_text] = "Could not add that product to your cart"
      flash[:messages] = @cart_entry.errors
      redirect_to product_path(@product.id)
    end
  end



  private

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

  def product_params
    params.require(:product).permit(:name, :description, :user_id, :price, :category_id)
  end

  def find_product
    @product = Product.find(params[:id].to_i)
  end

  def create_entry(input_quantity)
    entry = OrderProduct.new
    entry.product_id = @product.id
    entry.order_id = @pending_order.id
    entry.quantity = input_quantity.to_i
    return entry
  end

  end
