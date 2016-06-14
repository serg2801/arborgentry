class VendorsController < ApplicationController
  # before_action :is_admin?, only: [:index, :edit, :update, :destroy]
  # before_action :is_vendor_admin?, only: [:new, :create, :all_vendor_users]
  alias_method :current_user, :current_vendor

  def index
  	@vendors = Vendor.where('admin = (?)', false)
  end

  def show
  end

  def new
    @vendor = Vendor.new
  end

  def edit
  	@vendor = Vendor.find(params[:id])
  	respond_to do |format|
			format.html
			format.js
  	end
  end

  def create
    @vendor = Vendor.new(vendor_params.merge(parent_vendor_id: current_vendor.id))
    if @vendor.vendor_user!
      redirect_to @vendor
    else
      render 'new'
    end
  end

  def update
  	@vendor = Vendor.find(params[:id])
  	if @vendor.update_attributes(vendor_params)
  		@vendors = Vendor.where('admin = (?)', false)
      flash[:success]="Vendor updated successfully."
	  	respond_to do |format|
				format.html
				format.js
	  	end
	  else
	  	render 'edit'
  	end
  end

  def destroy
  	@vendor = Vendor.find(params[:id])
    authorize @vendor
  	@vendor.destroy
    @vendors = Vendor.where('admin = (?)', false)
  	flash[:success]="Vendor deleted successfully."
    respond_to do |format|
      format.html
      format.js
    end
  end

  def all_vendor_users
    @vendor = Vendor.find(current_vendor.id)
    @all_vendor_users = Vendor.where(parent_vendor_id: @vendor.id)
    authorize Vendor
  end

  private

    def vendor_params
      params.require(:vendor).permit!
    end

    def is_admin?
      if current_vendor
        unless current_vendor.admin? || current_vendor.vendor_admin?
          flash[:danger]="You have no rights"
          redirect_to(authenticated_root_path)
        end
      else
        redirect_to(new_vendor_session_path)
      end
    end
  def is_vendor_admin?
    current_vendor.vendor_admin?
  end
    
end
