class Admin::VariantsController < ApplicationController
	before_action :set_variants
	alias_method :current_user, :current_vendor
	def index
		
	end

	def new
		@variant = Variant.new
		# 3.times { @variant.option_values.build }
	end

	def create
		@variant = Variant.new(variant_params)
		@variant.save
	end

	def edit
		@variant = Variant.find(params[:id])
	end

	def update
		# exit
		@variant = Variant.find(params[:id])
		@variant.update_attributes(variant_params)
	end

	def destroy 
		@variant = Variant.find(params[:id])
		@variant.delete
	end

	private
	def variant_params
		params.require(:variant).permit(:product_id, :sku, :barcode, :weight, :weight_unit, :price, :compare_price, :is_master, option_values_attributes: [:id, :name, :_destroy])
	end

	def set_variants
		@variants = Variant.all
		@products = Product.all
	end
end
