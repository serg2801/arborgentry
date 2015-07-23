class Admin::CategoriesController < ApplicationController
	before_action :set_categories 
	def index
		
	end

	def new
		@category = Category.new
	end

	def create
		@category = Category.new(category_params)
		@category.save
	end

	def edit
		@category = Category.find(params[:id])
	end

	def update
		@category = Category.find(params[:id])
		@category.update_attributes(category_params)
	end

	def destroy 
		@category = Category.find(params[:id])
		@category.delete
	end

	private
	def category_params
		params.require(:category).permit(:vendor_ids,:title)
	end

	def set_categories
		@categories = Category.all
	end
end
