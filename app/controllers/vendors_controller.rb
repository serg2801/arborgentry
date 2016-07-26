class VendorsController < ApplicationController
  # before_action :is_admin?, only: [:index, :edit, :update, :destroy]
  # before_action :is_vendor_admin?, only: [:new, :create, :all_vendor_users]
  alias_method :current_user, :current_vendor
  before_action :set_vendor, only: [:show, :edit, :update, :destroy, :logged_in_as_vendor]
  before_action :set_roles, only: [ :new_vendor, :edit ]
  def index
    @all_vendor_users = Vendor.where(parent_vendor_id: current_vendor.id)
    authorize Vendor
  end

  def show
    authorize Vendor
  end

  def new_vendor
    @vendor = Vendor.new
    authorize Vendor
  end

  def create_vendor
    # o = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
    # password_string = (0...20).map { o[rand(o.length)] }.join
    password_string = 'password'
    if current_vendor.has_role? :admin
      @vendor = Vendor.new(vendor_params.merge(parent_vendor_id: current_vendor.id, password: password_string, password_confirmation: password_string, account_id: params[:account_id].to_i))
      @vendor.add_role :vendor_admin
      @vendor.spree_roles << Spree::Role.find_or_create_by(name: 'admin')
    elsif current_vendor.has_role? :vendor_admin
      role = Role.find(params[:role_id])
      @vendor = Vendor.new(vendor_params.merge(parent_vendor_id: current_vendor.id, password: password_string, password_confirmation: password_string))
      @vendor.spree_roles << Spree::Role.find_or_create_by(name: 'admin')
      @vendor.add_role role.name
      @vendor.spree_roles << Spree::Role.find_or_create_by(name: 'admin')
    end
    if @vendor.save
      VendorMailer.email_vandor_pass( @vendor, password_string ).deliver
      flash[:success] = 'Vendor added successfully.'
      redirect_to @vendor
    else
      flash[:danger] = 'Error.'
      render 'new_vendor'
    end
    authorize Vendor
  end

  def edit
    respond_to do |format|
      format.html
      format.js
    end
    authorize Vendor
  end

  def update
    authorize Vendor
    if @vendor.update_attributes(vendor_params.merge(account_id: params[:account_id].to_i))
      @vendor.update_role(params[:role_id]) if current_vendor.has_role? :vendor_admin
      @vendors = Vendor.where(parent_vendor_id: current_vendor.id)
      flash[:success] = 'Vendor updated successfully.'
      respond_to do |format|
        format.html
        format.js
      end
    else
      render 'edit'
    end
  end

  def destroy
    authorize Vendor
    @vendor.destroy
    @vendors = Vendor.where(parent_vendor_id: current_vendor.id)
    flash[:success] = 'Vendor deleted successfully.'
    respond_to do |format|
      format.html
      format.js
    end
  end

  def logged_in_as_vendor
    session[:relogin_id] = current_vendor.id if session[:relogin_id].blank?
    sign_out current_vendor
    sign_in @vendor, event: :authentication
    flash[:success] = "Logged in as user #{current_vendor.first_name}
                       #{current_vendor.last_name}."
    redirect_to @vendor
  end

  def back_login_by_admin
    id = session[:relogin_id]
    vendor = Vendor.find(id)
    sign_out current_vendor
    sign_in vendor, event: :authentication
    flash[:success] = 'Logged in successfull!'
    session.delete(:relogin_id)
    redirect_to vendors_path
  end

  def profile
    @vendor = Vendor.find(current_vendor.id)
    # @board_user = @user.board
    @vendor_form = @vendor.vendor_form
    # @information_trades = @user.trade.information_trades
  end

  private

  def vendor_params
    params.require(:vendor).permit!
  end

  def is_admin?
    if current_vendor
      unless current_vendor.admin? || current_vendor.vendor_admin?
        flash[:danger] = 'You have no rights'
        redirect_to(authenticated_root_path)
      end
    else
      redirect_to(new_vendor_session_path)
    end
  end

  def is_vendor_admin?
    current_vendor.vendor_admin?
  end

  #Before filters

  def set_vendor
    @vendor = Vendor.find(params[:id])
  end

end
