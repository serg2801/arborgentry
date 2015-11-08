class VendorsController < ApplicationController
  before_action :is_admin?, only: [:index, :edit, :update, :destroy]
  def index
  	@vendors = Vendor.where('admin = (?)', false)
  end

  def edit
  	@vendor = Vendor.find(params[:id])
  	respond_to do |format|
			format.html
			format.js
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
  	@vendor.destroy
    @vendors = Vendor.where('admin = (?)', false)
  	flash[:success]="Vendor deleted successfully."
    respond_to do |format|
      format.html
      format.js
    end
  end

  private

    def vendor_params
      params.require(:vendor).permit!
    end

    def is_admin?
      if current_vendor
        unless current_vendor.admin?
          flash[:danger]="You have no rights"
          redirect_to(authenticated_root_path)
        end
      else
        redirect_to(new_vendor_session_path)
      end
    end
    
end
