class VendorFormsController < ApplicationController

  skip_before_filter :authenticate_vendor!
  alias_method :current_user, :current_vendor

  layout 'vendor_form', only: [:new, :create]

  before_action :get_vendor_form_options, only: [:create, :update]

  def index
    authorize VendorForm
    @vendor_forms = VendorForm.all
  end

  def show
    @vendor_form = VendorForm.find(params[:id])
    authorize @vendor_form
  end

  def edit
    authorize VendorForm.find(params[:id])
    @vendor = Vendor.find(current_vendor.id)
    @vendor_form = @vendor.vendor_form
  end

  def new
    @vendor_form = VendorForm.new
  end

  def create
    @vendor_form = VendorForm.new(vendor_form_params)
    if vendor_form_options
      save_vendor_form_options(@vendor_form)
      if @vendor_form.save
        VendorFormMailer.sing_up_confirmation(@vendor_form).deliver
        VendorFormMailer.send_confirmation(@vendor_form).deliver
        redirect_to vendor_success_path
      else
        render 'new'
      end
    end
  end

  def grant_access
    authorize VendorForm
    @vendor_form = VendorForm.find(params[:id])
    # password_string = VendorForm.generate_password
    password_string = 'password'
    @vendor = Vendor.new({email: @vendor_form.email, password: password_string, password_confirmation: password_string, pas_decrypt: VendorForm.encryption(password_string)})
    if @vendor.save
      @vendor_form = VendorForm.find(params[:id])
      @vendor_form.update_attributes(grant_access: true, vendor_id: @vendor.id)
      VendorFormMailer.create_vendor(@vendor_form, @vendor).deliver
    end
    redirect_to vendor_forms_path
  end

  def update
    authorize VendorForm.find(params[:id])
    @vendor = Vendor.find(current_vendor.id)
    @vendor_form = @vendor.vendor_form
    if vendor_form_options
      @vendor_form.category_forms.each do |category|
        @vendor_form_category = VendorFormCategoryForm.find_by(category_form_id: category.id, vendor_form_id: @vendor_form.id)
        @vendor_form_category.destroy
      end
      @categories.each do |category|
        @category = CategoryForm.find(category)
        @vendor_form.category_forms << @category
      end

      @vendor_form.channel_forms.each do |channel|
        @vendor_form_channel = VendorFormChannelForm.find_by(channel_form_id: channel.id, vendor_form_id: @vendor_form.id)
        @vendor_form_channel.destroy
      end
      @channels.each do |channel|
        @channel = ChannelForm.find(channel)
        @vendor_form.channel_forms << @channel
      end

      @vendor_form.option_forms.each do |option|
        @vendor_form_option = VendorFormOptionForm.find_by(option_form_id: option.id, vendor_form_id: @vendor_form.id)
        @vendor_form_option.destroy
      end
      @options.each do |option|
        @option = OptionForm.find(option)
        @vendor_form.option_forms << @option
      end

      if @vendor_form.update_attributes(vendor_form_params)
        VendorFormMailer.update_vendor_form(@vendor_form).deliver
        redirect_to vendor_form_success_update_path
      else
        render :edit
      end
    end
  end

  private

  def vendor_form_options
    if @categories.nil?
      flash[:warning] = 'Please, indicate the options that describe your business!'
      render 'new'
      false
    elsif @channels.nil?
      flash[:warning] = 'Please, indicate what categories would you like to see on Tandem Arbor!'
      render 'new'
      false
    elsif @options.nil?
      flash[:warning] = 'Please, indicate What channel(s) do you currently sell through!'
      render 'new'
      false
    else
      true
    end
  end

  def save_vendor_form_options(vendor_form)
    @categories.each do |category_id|
      @category = CategoryForm.find(category_id)
      vendor_form.category_forms << @category
    end

    @channels.each do |channel_id|
      @channel = ChannelForm.find(channel_id)
      vendor_form.channel_forms << @channel
    end

    @options.each do |option_id|
      @option = OptionForm.find(option_id)
      vendor_form.option_forms << @option
    end
  end

  def vendor_form_params
    params.require(:vendor_form).permit(:business_name, :greeting, :first_name, :last_name, :email, :phone_number, :address,
                                        :suite, :city, :state, :zipcode, :country, :web_site_url_my, :web_site, :information,
                                        :image, :option_ids, :category_ids, :channel_ids)
  end

  #Before filters

  def get_vendor_form_options
    @categories = params[:vendor_form][:category_ids]
    @channels = params[:vendor_form][:channel_ids]
    @options = params[:vendor_form][:option_ids]
  end

end
