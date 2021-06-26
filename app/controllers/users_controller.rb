class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  before_action :baria_user, only: %i[ edit update destroy ]

  def new
  @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to photos_path
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path
    else
      render :edit
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private
  def baria_user
    unless User.find(params[:id]).id.to_i == current_user.id
      redirect_to user_path(current_user)
    end
  end

  def user_params
  params.require(:user).permit(:name, :email, :password, :password_confirmation, :image)
  end
end
