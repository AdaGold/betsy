class ProductsController < ApplicationController
before_action :find_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.all
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

  private

  def find_product
    @product = Product.find_by_id(params[:id])
  end

end
