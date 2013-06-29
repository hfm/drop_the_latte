class UsersController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @photos = @user.photos.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to root_path
  end
  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "ログインしてください。"
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end
end
