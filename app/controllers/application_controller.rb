class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  before_action :set_locale
  before_action :set_current_user
  before_action :set_current_order

  protect_from_forgery with: :exception

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  private
  
  def record_not_found
    render status: 404, formats: [:html], template: 'layouts/404_error', without: :flash
  end

  def require_login
    unless @current_user
      flash[:danger] = I18n.t('flash_messages.need_authorize')
      redirect_to login_path
    end
  end

  def manager_permission
    unless @current_user.try(:moderator?)
      danger
    end
  end

  def admin_permission
    unless @current_user.try(:admin?)
      danger
    end
  end

  def danger
    flash[:danger] = I18n.t('flash_messages.permission_denied')
    redirect_to root_path
  end
    
  def set_current_user
    return @current_user if @current_user
    if session[:user_id] && user = User.find(session[:user_id])
      @current_user = user
      session[:user_id] = @current_user.id
    else
      session[:user_id] = nil
    end
    return @current_user
  end

  def set_current_order
    return @current_order if @current_order
    if @current_user
      order = @current_user.orders.first || Order.create(user: @current_user)
      @current_order = order
    elsif session[:order_id]
      @current_order = Order.find(session[:order_id]) || Order.create
    else
      @current_order = Order.create
    end
    session[:order_id] = @current_order.id
    @current_order
  end
end
