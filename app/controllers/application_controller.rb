class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

private
  def find_user
    if session[:user_id]
      @login_user = User.find_by(id: session[:user_id])
    end
  end
end
