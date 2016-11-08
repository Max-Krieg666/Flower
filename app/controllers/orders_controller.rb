class OrdersController < ApplicationController
  before_action :require_login, except: [:submit_order, :destroy]
  before_action :manager_permission, except: [:submit_order, :destroy]

  def index
    @new_orders = Order.where(status: 1).ordering.page(params[:page])
    @delivery = Order.where(status: 4).ordering.page(params[:page])
    @completed = Order.where(status: 5).ordering.page(params[:page])
    @cancelled = Order.where(status: 3).ordering.page(params[:page])
  end

  def show
  end

  def edit
  end

  def submit_order
    if @current_order.update(order_params)
      redirect_to root_path, notice: I18n.t('flash_messages.order_was_issued_successfully')
    else
      redirect_to line_items_path, params: params
    end
  end

  def update
    respond_to do |format|
      if @current_order.update(order_params)
        @current_order.update(status: 1)
        format.html { redirect_to @current_order, notice: I18n.t('flash_messages.order_was_updated_successfully') }
        format.json { render :show, status: :ok, location: @current_order }
      else
        format.html { render :edit }
        format.json { render json: @current_order.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    path = !@current_user || @current_user && @current_user.user? ? root_path : orders_url
    @current_order.update(status: 3)
    redirect_to path, notice: I18n.t('flash_messages.order_was_canceled')
  end

  private
  
  def order_params
    params.require(:order).permit(:user_id, :address, :status, :comment, :fio, :phone)
  end
end
