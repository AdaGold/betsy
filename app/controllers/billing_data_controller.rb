class BillingDataController < ApplicationController

  # def index
  #   @billing_data = Billing_data.order(:id)
  # end

  def show
    @billing_data = BillingDatum.find_by(id: params[:id].to_i)

    unless @billing_data
      flash[:error] = "Billing data not found"
      redirect_to root_path
    end
  end

  def edit
    @billing_data = BillingDatum.find_by(id: params[:id].to_i)

    unless @billing_data
      redirect_to root_path
    end
  end


  def update
    @billing_data = BillingDatum.find_by(id: params[:id].to_i)

    if @billing_data.update_attributes billing_data_params
      redirect_to root_path
    else
      render :edit
    end
  end


  def new
    @billing_data = BillingDatum.new
  end


  def create
    @billing_data = BillingDatum.new billing_data_params

    if @billing_data.save
      redirect_to root_path
    else
      flash.now[:error] = "Could not create Billing Data"
      render :new
    end
  end


  def destroy
    @billing_data = BillingDatum.find_by(id: params[id].to_i)
    @billing_data.destroy
    redirect_to root_path
  end


  private

  def billing_data_params
    return params.require(:billing_data).permit(:email, :mailig_address, :credit_card_name, :credit_card_number, :credit_card_cvv, :billing_zip_code)
  end
end




#
