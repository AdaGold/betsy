class CategoriesController < ApplicationController

  #displays all categories in alphabetical order
  def index
    @categories = Categories.order(:id)
  end

  #show all products in a specific category
  def show
    @category = Category.find_by(id: params[:id])

  end

  #makes changes to a category that's already created
  def edit
  end

  def update
  end

  #sign-in user can create a new category
  def new
  end

  def create
  end

  #signed-in user can delete a category
  def destroy
  end
end
