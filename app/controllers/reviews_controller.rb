class ReviewsController < ApplicationController
  def show
  end

  def new
    @review = Review.new(product_id: params[:pass_product_id])

  end

  def create
    @review = Review.new(product_id: params[:review][:product_id], rating: params[:review][:rating], review_text: params[:review][:review_text])
    if @review.save
      redirect_to product_path(@review.product_id)
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def index
  end


end
