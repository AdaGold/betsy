class ReviewsController < ApplicationController
  def show
  end

  def new
    @review = Review.new(product_id: params[:product_id])

    if session[:merchant_id] == @review.product.merchant_id
      flash[:status] = :error
      flash[:result_text] = "Merchant can't leave reviews of their own products, sorry! Wink-wink."
      redirect_to product_path(@review.product_id) #, status: 403
    end
  end

  def create
    @review = Review.new(review_params)

    if session[:merchant_id] != @review.product.merchant.id
      if @review.save
        redirect_to product_path(@review.product_id)
      else
        flash[:status] = :error
        flash[:result_text] = "Review failed to be added"
        flash[:messages] = @review.errors.messages
        redirect_to new_review_path(@review.product_id)
      end
    else
      flash[:status] = :error
      flash[:result_text] = "Merchant can't leave reviews of their own products, sorry! Wink-wink."
      redirect_to product_path(@review.product_id), status: 403
    end
  end

  def edit
  end

  def update
  end

  def index
  end

  private

  def review_params
    return params.require(:review).permit(:product_id, :rating, :review_text, :title)
  end

end
