class UsersController < ApplicationController
  before_action :permission, except: [:index, :show]

  def new
    @user = User.new
  end

  def index
    @users = []
    User.all.each do |user|
      if user.products.length > 0
        @users.push(user)
      end
    end
    return @users
  end

  def show
    @user = User.find_by(id: params[:id].to_i)
    # render_404 unless @user

    unless @user
      flash[:error] = "User not found"
      redirect_to root_path
    end
  end

  def create
    @user = User.new user_params

    if @user.save
      flash[:success] = "User added successfully"
      redirect_to root_path
    else
      flash.now[:error] = "User not added"
      render :new
    end
  end

  def login
  end

  def update
    @user = User.find_by(id: params[:id].to_i)
    redirect_to root_path

    unless @user
      redirect_to users_path
    end
  end

  def profile
    @user = @user
  end

  def order_fulfillment
    @entries = @user.merchant_entries
    organize_entries if @entries

  end


  # TODO if the user is to be deleted, me must then delete all of there products.
  # def destroy
  #   @user = User.find_by(id: params[:id])
  #   @user.destroy
  #
  #   redirect_to root_path
  # end

# ---------------------------------------
  # def edit
  # end
# ---------------------------------------



  private

  def user_params
    return params.require(:users).permit(:username, :email)
  end

  def permission
    if !(@user)
      render_404
    end
  end

  def render_404
  render file: "/public/404.html", status: 404
  end

  def organize_entries
    @paid_entries = []
    @shipped_entries = []
    @canceled_entries = []
    @entries.each do |entry|
      @paid_entries << entry if entry.paid?
      @shipped_entries << entry if entry.shipped?
      @canceled_entries << entry if entry.canceled?
    end
  end
end
