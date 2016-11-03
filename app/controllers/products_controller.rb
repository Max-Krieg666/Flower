class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :manager_permission, except: [:index, :show]

  def index
    @products = Product.page(params[:page])
  end

  def show
    @same_products = Product.where.not(id: @product.id).where(kind: @product.kind).limit(3)
  end

  def new
    @product = Product.new
  end

  def edit
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to @product, notice: 'Продукт успешно создан.'
    else
      render :new
    end
  end

  def update
    if @product.update(product_params)
      redirect_to @product, notice: 'Продукт успешно изменен.'
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to products_url, notice: 'Продукт успешно уничтожен.'
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:title, :image, :description, :price, :color)
    end
end
