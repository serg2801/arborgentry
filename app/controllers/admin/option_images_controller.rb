class Admin::OptionImagesController < ApplicationController
	alias_method :current_user, :current_vendor
	def new
		@option_image = OptionImage.new
	end

	def create
		exit
	end
end
