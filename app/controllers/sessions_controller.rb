class SessionsController < ApplicationController


  def login_form
  end

  def not_logged_in
  end

  def login
    username = params[:username]
    if username && user = User.find_by(user: username)
      session[:user_id] = user.id
      flash[:status] = :success
      flash[:result_text] = "Successfully logged in as #{@user.username}"
      redirect_to root_path
    else
      user = User.new(username: username)
      if user.save
        session[:user_id] = @user.id
        flash[:success] = "Successfully created user: #{@user.username}"
        redirect_to root_path
      else
        flash.now[:status] = :failure
        flash.now[:result_text] = "Could not log in"
        flash.now[:messages] = users.errors.messages
        render "login_form", status: bad_request
      end
    end
  end

  def create
    @auth_hash = request.env['omniauth.auth']
    # ap @auth_hash

    @user = User.find_by(uid: @auth_hash['uid'], provider: @auth_hash['provider'])

    if @user
      session[:user_id] = @user.id
      flash[:result_text] = "#{@user.username} has been logged in!"

    else
      @user = User.new(uid: @auth_hash['uid'], provider: @auth_hash['provider'], email: @auth_hash['info']['email'], username: @auth_hash['info']['nickname'])
      @user.save
      if @user.save
        session[:user_id] = @user.id
        flash[:result_text] = "#{@user.username} has been logged in!"
      else
        flash[:result_text] = "Unable to save user!"
      end
    end
    redirect_to root_path
  end

  def logout
    session[:user_id] = nil
    flash[:result_text] = "Successfully logged out!"
    session[:pending_order_id] = nil

    redirect_to root_path
  end
end
