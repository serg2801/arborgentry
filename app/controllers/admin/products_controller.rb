class Admin::ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  respond_to :js, only: [:edit,:new,:show,:create,:destroy,:update]
  respond_to :html

  def index
    @products = Product.all
    respond_with(@products)
  end

  def show
    admin_product_path(@product)
  end

  def new
    @product = Product.new
    respond_with(@product)
  end

  def edit
  end

  def create
    @product = Product.new(product_params)
    flash[:success] = 'Product was successfully created.' if @product.save
    @products = Product.all
    admin_product_path(@product)
  end

  def update
    flash[:success] = 'Product was successfully updated.' if @product.update(product_params)
    @products = Product.all
    admin_product_path(@product)
  end

  def destroy
    @product.destroy
    @products = Product.all
    flash[:success] = 'Product deleted successfully.'
    respond_with(@product)
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :description, :slug, :meta_description, :meta_keywords, :publish_date, :vendor_id)
    end
end
