class UsersController < ApplicationController
  # TODO добавить личный кабинет юзера на #show и историю заказов!
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    session[:user_id] = @user.id
    if @user.save
      redirect_to root_path, notice: I18n.t('flash_messages.user_was_registered_successfully')
    else
      render :new
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: I18n.t('flash_messages.user_was_updated_successfully') }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: I18n.t('flash_messages.user_was_destroyed_successfully') }
      format.json { head :no_content }
    end
  end

  private
  
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :phone_number, :address)
  end
end
