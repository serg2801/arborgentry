class CategoriesController < ApplicationController
	before_action :set_categories 
	def index
		
	end

	def new
		@category = Category.new
	end

	def create
		@category = Category.new(category_params)
		@category.save
		# set_categories
		# 	redirect_to categories_path, notice: "category created successfully"
		# else
		# 	redirect_to :back
		# end
	end

	def edit
		@category = Category.find(params[:id])
	end

	def update
		@category = Category.find(params[:id])
		@category.update_attributes(category_params)
		# 	redirect_to categories_path, notice: "category updated successfully"
		# else
		# 	redirect_to :back
		# end
	end

	def destroy 
		@category = Category.find(params[:id])
		@category.delete
		# redirect_to categories_path, notice: "Category deleted successfully"
	end

	private
	def category_params
		params.require(:category).permit(:vendor_ids,:title)
	end

	def set_categories
		@categories = Category.all
	end
end
