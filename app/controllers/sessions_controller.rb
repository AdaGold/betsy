class SessionsController < ApplicationController
  def create
    @auth_hash = request.env['omniauth.auth']

    @merchant = Merchant.find_by(oauth_uid: @auth_hash['uid'], oauth_provider: @auth_hash['provider'])

    if @merchant
      session[:merchant_id] = @merchant.id
      flash[:success] = "#{@merchant.username} is logged in!"
    else
      @merchant = Merchant.new oauth_uid: @auth_hash['uid'], oauth_provider: @auth_hash['provider'], username: @auth_hash['info']['nickname'], email: @auth_hash['info']['email']
      if @merchant.save
        session[:merchant_id] = @merchant.id
        flash[:success] = "New user: #{@merchant.username} is logged in!"
      else
        flash[:error] = "Unable to save user :( "
      end
    end#ifelse
    redirect_to root_path
  end #create

  def logout
    session[:merchant_id] = nil
    flash[:status] = :success
    flash[:result_text] = "Successfully logged out"
    redirect_to root_path
  end

  # def index
  # end
end
