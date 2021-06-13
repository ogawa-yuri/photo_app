class SessionsController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  def new
  end

  def create
    user = User.find_by(email: params[:sessions][:email].downcase)
    if user && user.authenticate(params[:sessions][:password])
      session[:user_id] = user.id
      redirect_to photos_path
    else
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to new_session_path
  end

end
