class CategoriesController < ApplicationController

  #home page shows all categories and a sampling of their products
  def root
  end

  #displays all categories in alphabetical order
  def index
    @categories = Categories.order(name: :desc)
  end

  #show all products in a specific category
  def show
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
