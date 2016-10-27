class OrdersController < ApplicationController
  before_action :require_login
  before_action :manager_permission

  def index
    # @orders = Order.ordering.page(params[:page])
    @new_orders = Order.where(status: 1).ordering.page(params[:page])
    @delivery = Order.where(status: 4).ordering.page(params[:page])
    @completed = Order.where(status: 5).ordering.page(params[:page])
    @cancelled = Order.where(status: 3).ordering.page(params[:page])
  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @current_order.update(order_params)
        format.html { redirect_to @current_order, notice: 'Заказ изменён.' }
        format.json { render :show, status: :ok, location: @current_order }
      else
        format.html { render :edit }
        format.json { render json: @current_order.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @current_order.update(status: 3)
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Заказ отменён.' }
      format.json { head :no_content }
    end
  end

  private
    def order_params
      params.require(:order).permit(:user_id, :address, :status, :comment, :fio, :phone)
    end
end
