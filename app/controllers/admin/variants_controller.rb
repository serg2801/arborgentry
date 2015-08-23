class Admin::VariantsController < ApplicationController
	before_action :set_variants
	def index
		
	end

	def new
		@variant = Variant.new
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
		params.require(:variant).permit(:sku, :barcode, :weight, :weight_unit, :price, :compare_price, :is_master)
	end

	def set_variants
		@variants = Variant.all
	end
end
