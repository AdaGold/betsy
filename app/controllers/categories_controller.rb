class CategoriesController < ApplicationController

  def index
    @categories = Category.order(:id)
    @user = session[:user_id]
  end

  #show all products in a specific category
  def show
    @category = Category.find_by(id: params[:id])
    unless @category
      flash[:error] = "Category does not exist"
      redirect_to root_path
    end
  end

  #makes changes to a category that's already created
  def edit
    @category = Category.find_by(id: params[:id])
    unless @category
      redirect_to categories_path
    end
  end

  def update
    @category = Category.find_by(id: params[:id])
    redirect_to categories_path unless @category

    if @category.update_attributes category_params
      flash[:success] = "Category edited successfully"
      redirect_to categories_path
    else
      flash.now[:error] = "Category not edited successfully"
      render :edit
    end

  end

  #sign-in user can create a new category
  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      puts "SUCCESS"
      flash[:success] = "Category created!"

      redirect_to user_path(@user)

    else
      puts "FAIL"
      flash.now[:error] = "Could not create category"
      render :new
    end
  end

  #signed-in user can delete a category
  def destroy
    @category = Category.find_by(id: params[:id])
    @category.destroy
    flash[:status] = :success
    flash[:result_text] = "Successfully destroyed category"
    redirect_to categories_path
  end

  private

  def category_params
    return params.require(:category).permit(:name)
  end
end
