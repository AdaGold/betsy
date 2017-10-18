class SessionsController < ApplicationController
  def create
    @auth_hash = request.env['omniauth.auth']

    @merchant = Merchant.find_by(uid: @auth_hash['uid'], provider: @auth_hash['provider'])
    if @merchant
      session[:user_id] = @merchant.id
      flash[:success] = "#{@merchant.username} is logged in!"
    else
      @merchant = Merchant.new uid: @auth_hash['uid'], provider: @auth_hash['provider'], name: @auth_hash['info']['nickname'], email: @auth_hash['info']['email'])
      if @merchant.save
        session[:user_id] = @merchant.id
        flash[:success] = "New user: #{@merchant.username} is logged in!"
      else
        flash[:error] = "Unable to save user :( "
      end
    end#ifelse
    redirect_to root_path
  end #create

  def index
  end
end
