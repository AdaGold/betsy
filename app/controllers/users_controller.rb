class UsersController < ApplicationController


  def new
    @user = User.new
  end

  def index
    @users = User.order(:id)
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
end
