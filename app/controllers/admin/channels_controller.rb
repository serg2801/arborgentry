class Admin::ChannelsController < ApplicationController
	before_action :set_channels 
	def index
		
	end

	def new
		@channel = Channel.new
	end

	def create
		@channel = Channel.new(channel_params)
		@channel.save
		# if @channel.save
		# 	redirect_to channels_path, notice: "Channel created successfully"
		# else
		# 	redirect_to :back
		# end
	end

	def edit
		@channel = Channel.find(params[:id])
	end

	def update
		@channel = Channel.find(params[:id])
		@channel.update_attributes(channel_params)
		# 	redirect_to channels_path, notice: "Channel updated successfully"
		# else
		# 	redirect_to :back
		# end
	end

	def destroy 
		@channel = Channel.find(params[:id])
		@channel.delete
		# redirect_to channels_path, notice: "Channel deleted successfully"
	end

	private
	def channel_params
		params.require(:channel).permit(:vendor_ids,:title)
	end

	def set_channels
		@channels = Channel.all
	end
end
