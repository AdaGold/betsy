class ProductsController < ApplicationController
  before_action :find_product, except: [:index, :new, :create]
  before_action :permission, except: [:show, :index, :add_to_order]
  before_action :owns, only: [:edit, :update]

  def index
    @products = Product.show_available
  end

  def show
    @current_user_is_not_product_owner = session[:user_id] != @product.user_id

    @user = @product.user
    unless @product
      render :not_found
    end
  end

  def edit
    if @product.id.nil?
      render render_404
    end
  end

  def update
    unless @product
      render render_404
    end

    @product.update_attributes product_params
    if @product.save
      flash[:status] = :success
      flash[:result_text] = "Successfully updated #{@product.name}"
      redirect_to profile_path(@user)
    else
      flash[:status] = :failure
      flash[:result_text] = "Could not update #{@product.name}"
      flash.now[:messages] = @product.errors.message
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

  def add_to_order
    # binding.pry
    @cart_entry = @pending_order.check_for_duplicates(@product.id)
    if @cart_entry
      @cart_entry.quantity += params[:quantity].to_i
    else
      @cart_entry = create_entry(params[:quantity])
    end

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

  def change_visibility
    if @product.visibility == false
      @product.visibility = true
      @product.save
      flash[:result_text] = "Your product is now visible in browsing"
      redirect_back(fallback_location: products_path)

    else
      # binding.pry
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

  def entry_params
    # params.require(:entry).permit(:quantity)
    # return
  end

  def find_product
    @product = Product.find_by(id: params[:id].to_i)
  end


  def permission
    unless @user
      render render_404
    end
  end

  def owns
    unless @product && @user.id == @product.user_id
      render render_404
    end
  end


  def create_entry(input_quantity)
    entry = OrderProduct.new
    entry.product_id = @product.id
    entry.order_id = @pending_order.id
    entry.quantity = input_quantity.to_i
    return entry
  end

end
