class CategoriesController < ApplicationController

  #displays all categories in alphabetical order
  def index
    @categories = Category.order(:id)
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
  end

  def update
  end

  #sign-in user can create a new category
  def new
    @category = Category.new
  end

  def create
    @category = Category.new
    if @category.save
      puts "SUCCESS"
      flash[:success] = "Category created!"
      redirect_to categories_path
    else
      puts "FAIL"
      flash.now[:error] = "Could not create category"
      render :new
    end
  end

  #signed-in user can delete a category
  def destroy
  end
end
