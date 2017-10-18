class ReviewsController < ApplicationController
  def show
  end

  def new
    @review = Review.new(product_id: param[:pass_product_id])
  end

  def create

  end

  def edit
  end

  def update
  end

  def index
  end


end
