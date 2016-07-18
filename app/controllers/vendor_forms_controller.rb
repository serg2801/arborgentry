class VendorFormsController < ApplicationController
  skip_before_filter :authenticate_vendor!
  alias_method :current_user, :current_vendor

  layout 'vendor_form'


  def edit
    # @user = User.find(current_user.id)
    # @trade = @user.trade
  end

  def new
    @vendor_form = VendorForm.new
  end

  def create
    @vendor_form = VendorForm.new(vendor_form_params)
    @categories = params[:trade][:category_ids]
    @channels = params[:trade][:channel_ids]
    @options = params[:trade][:option_ids]

    if @categories.nil?
      flash[:warning] = "Please, indicate the options that describe your business!"
      render 'new'
    elsif @channels.nil?
      flash[:warning] = "Please, indicate what categories would you like to see on Tandem Arbor!"
      render 'new'
    elsif @options.nil?
      flash[:warning] = "Please, indicate What channel(s) do you currently sell through!"
      render 'new'
    else
      @categories.each do |category|
        @category = Category.find(category)
        @trade.categories << @category
      end

      @channels.each do |channel|
        @channel = Channel.find(channel)
        @trade.channels << @channel
      end

      @options.each do |option|
        @option = Option.find(option)
        @trade.options << @option
      end

      if @vendor_form.save
        # TradeMailer.signup_confirmation(@vendor_form).deliver
        # TradeMailer.send_confirmation(@vendor_form).deliver
        redirect_to vendor_success_path
      else
        render 'new'
      end
    end
  end

  def update
    @user = User.find(current_user.id)
    @vendor_form = @user.trade
    @categories = params[:vendor_form][:category_ids]
    @channels = params[:vendor_form][:channel_ids]
    @options = params[:vendor_form][:option_ids]

    if @categories.nil?
      flash[:warning] = "Please, indicate the options that describe your business!"
      render 'new'
    elsif @channels.nil?
      flash[:warning] = "Please, indicate what categories would you like to see on Tandem Arbor!"
      render 'new'
    elsif @options.nil?
      flash[:warning] = "Please, indicate What channel(s) do you currently sell through!"
      render 'new'
    else
      @trade.categories.each do |category|
        @trade_category = TradeCategory.find_by(category_id: category.id, trade_id: @trade.id)
        @trade_category.destroy
      end
      @categories.each do |category|
        @category = Category.find(category)
        @trade.categories << @category
      end

      @trade.channels.each do |channel|
        @trade_channel = TradeChannel.find_by(channel_id: channel.id, trade_id: @trade.id)
        @trade_channel.destroy
      end
      @channels.each do |channel|
        @channel = Channel.find(channel)
        @trade.channels << @channel
      end

      @trade.options.each do |option|
        @trade_option = TradeOption.find_by(option_id: option.id, trade_id: @trade.id)
        @trade_option.destroy
      end
      @options.each do |option|
        @option = Option.find(option)
        @trade.options << @option
      end

      if @vendor_form.update_attributes(vendor_form_params)
        # TradeMailer.update_trade(@vendor_form).deliver
        redirect_to trade_success_update_path
      else
        render :edit
      end
    end
  end

  private
  def vendor_form_params
    params.require(:trade).permit(:business_name, :greeting, :first_name, :last_name, :email, :phone_number, :address,
                                  :suite, :city, :state, :zipcode, :country, :web_site_url_my, :web_site, :information,
                                  :image, :option_ids, :category_ids, :channel_ids)
  end

end
