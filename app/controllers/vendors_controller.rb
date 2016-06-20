class VendorsController < ApplicationController
  # before_action :is_admin?, only: [:index, :edit, :update, :destroy]
  # before_action :is_vendor_admin?, only: [:new, :create, :all_vendor_users]
  alias_method :current_user, :current_vendor
  before_action :set_vendor, only: [:show, :edit, :update, :destroy]

  def index
    # @vendors = Vendor.where.not(role: 'admin')
    @all_vendor_users = Vendor.where(parent_vendor_id: current_vendor.id)
    authorize Vendor
  end

  def show
  end

  def new_vendor
    @vendor = Vendor.new
    authorize Vendor
  end

  def create_vendor
    # o = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
    # password_string = (0...20).map { o[rand(o.length)] }.join
    password_string = 'password'
    @vendor = Vendor.new(vendor_params.merge(parent_vendor_id: current_vendor.id, password: password_string, password_confirmation: password_string))
    if @vendor.save
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
    if @vendor.update_attributes(vendor_params)
      @vendors = Vendor.where('admin = (?)', false)
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
    @vendor.destroy
    @vendors = Vendor.where('admin = (?)', false)
    flash[:success] = 'Vendor deleted successfully.'
    respond_to do |format|
      format.html
      format.js
    end
    authorize Vendor
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
