class MessagesController < ApplicationController
  before_action :set_message, only: [ :show, :destroy ]

  def index
    @messages = Message.all
  end

  def show
  end

  def destroy
    if @message.destroy
      redirect_to messages_path
      flash[:notice] = "Your message was deleted!"
    end
  end

  private

  # Before filters

  def set_message
    @message = Message.find(params[:id])
  end


end
