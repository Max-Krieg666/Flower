class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.where(email: params[:email]).first
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to root_path, notice: I18n.t('flash_messages.authorize_successfully')
    else
      flash[:danger] = I18n.t('flash_messages.incorrect_email_or_password')
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path, notice: I18n.t('flash_messages.exit_successfully')
  end
end
