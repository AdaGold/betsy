class ReviewsController < ApplicationController
  def index
    @reviews = Review.order(:id)
  end

  def show
    @review = Review.find_by(id: params[:id].to_i)

    unless @review
      flash[:error] = "Review not found"
      redirect_to root_path
    end
  end



  def edit
    @review = Review.find_by(id: params[:id].to_i)
    unless @review
      redirect_to root_path
    end
  end



  def update
    @review = Review.find_by(id: params[:id].to_i)

    if @review.update_attributes review_params
        redirect_to root_path
    else
      render :edit
    end
  end



  def new
    @review = Review.new
<<<<<<< HEAD
    @product = Product.find(params[:id])
=======
    @product = Product.find_by(id: params[:product_id].to_i)
>>>>>>> 4231e0d91982ce64af974e615ff7418ae9574a2f
  end



  def create
    @review = Review.new(review_params)

    if @review.save
      # redirect_to root_path
      redirect_to product_path(review_params[:product_id])
    else
      flash.now[:error] = "Could not create Review"
      render :new
    end
  end



  def destroy
    @review = Review.find_by(id: params[:id].to_i)
    @review.destroy
    redirect_to root_path
  end



  private

  def review_params
    return params.require(:review).permit(:user_id, :product_id, :text, :rating)
  end

end
