class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  before_action :set_current_user
  before_action :set_locale

  protect_from_forgery with: :exception
  before_action :set_current_order

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  private
    def record_not_found
      render plain: '404 Not Found', status: 404
    end
    
    def set_current_user
      if session[:user_id].present?
        @current_user = User.find(session[:user_id])
      end
    end

    def require_login
      unless @current_user
        # TODO перевести все мессаги с помощью i18n
        flash[:danger] = 'Требуется авторизация'
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

    def set_current_order
      @current_order = Order.find(session[:order_id])
    rescue ActiveRecord::RecordNotFound
      @current_order = Order.create(user: @user, status: 0)
      session[:order_id] = @current_order.id
    end

    def danger
      flash[:danger] = 'Недостаточно прав'
      redirect_to root_path
    end
end
