class LineItemsController < ApplicationController
  before_action :set_line_item, only: [:show, :edit, :update, :destroy]
  before_action :set_current_order

  def index
    @line_items = @current_order.line_items
  end

  def show
  end

  def new
    @line_item = LineItem.new
  end

  def edit
  end

  def create
    notice = I18n.t('flash_messages.product_added_to_cart')
    case params[:place]
    when nil
      @product = Product.find(params[:product_id])
      @current_order.add_item(@product)
      respond_to do |format|
        if params[:product].blank?
          format.html { redirect_to products_path, notice: notice }
          format.js {}
        else
          format.html { redirect_to product_path(params[:product]), notice: notice }
          format.js {}
        end
      end
    when "order"
      set_line_item
      @line_item.quantity += 1
      @line_item.save
      respond_to do |format|
        format.html { redirect_to @current_order, notice: notice }
        format.js {}
      end
    when "line_items"
      set_line_item
      @line_item.quantity += 1
      @line_item.save
      respond_to do |format|
        format.html { redirect_to line_items_path, notice: notice }
        format.js {}
      end
    end
  end

  def update
    respond_to do |format|
      if @line_item.update(line_item_params)
        format.html { redirect_to @line_item, notice: I18n.t('flash_messages.element_of_order_was_updated_successfully') }
        format.js {}
      else
        render :edit
      end
    end
  end

  def destroy
    notice = I18n.t('flash_messages.element_of_order_was_destroyed_successfully')
    if @line_item.quantity == 1
      @line_item.destroy
    else
      @line_item.quantity -= 1
      @line_item.save
    end
    respond_to do |format|
      case params[:place]
      when "order"
        format.html{ redirect_to @current_order, notice: notice }
        format.js{}
      when "line_items"
        format.html{ redirect_to line_items_path, notice: notice }
        format.js{}
      end
    end
  end

  private
  
  def set_line_item
    @line_item = LineItem.find(params[:id])
  end

  def line_item_params
    params.require(:line_item).permit(:quantity, :price, :order_id, :product_id)
  end
end
