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
    1.times do 
      variant = @product.variants.build
      1.times do
        option_type = variant.option_types.build
        1.times do
          option_value = option_type.option_values.build
          1.times{option_value.option_images.build}
        end
      end
    end
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
      params.require(:product).permit(:name, :description, :slug, :meta_description, :meta_keywords, :publish_date, :vendor_id,variants_attributes: [:id, :price, :sku, :barcode, :weight, :weight_unit, :compare_price, :is_master, :_destroy, option_types_attributes: [:id, :name, :_destroy, option_values_attributes: [:id, :name, :_destroy, option_images_attributes: [:id, :image, :_destroy]]]])
    end
end