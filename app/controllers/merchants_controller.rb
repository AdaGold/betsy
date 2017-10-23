class MerchantsController < ApplicationController
  before_action :find_merchant, only: [:show, :edit, :update, :destroy]
  before_action :account_owner?

  def new
  end

  def create
  end

  def index
  end

  def edit
  end

  def update
  end

  def show
  end

  private

  def find_merchant
    @merchant = Merchant.find_by_id(params[:id])
  end
  def account_owner?
    unless session[:merchant_id] == find_merchant.id
      flash[:status] = :error
      flash[:result_text] = "Unauthorized user"
      return redirect_back :fallback_location
    end
  end

end
