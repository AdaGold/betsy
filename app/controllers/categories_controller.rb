class CategoriesController < ApplicationController


  def root


  end

  #displays all categories in alphabetical order
  def index
    @categories = Categories.order(name: :desc)
  end

  def show
  end

  def edit
  end

  def update
  end

  def new
  end

  def create
  end

  def destroy
  end
end
