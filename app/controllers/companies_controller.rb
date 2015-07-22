class CompaniesController < ApplicationController
  before_action :is_admin?, only: [:new, :create, :index, :edit, :update, :destroy]

	def index
  	@companies = Company.all
  end

  def new
    @company = Company.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @company=Company.new(company_params)
    if @company.save
      @companies = Company.all
      flash[:success]="Company created successfully."
      respond_to do |format|
        format.html
        format.js
      end
    else
      render 'new'
    end
  end

  def edit
  	@company = Company.find(params[:id])
  	respond_to do |format|
			format.html
			format.js
  	end
  end

  def update
  	@company = Company.find(params[:id])
  	if @company.update_attributes(company_params)
  		@companies = Company.all
      flash[:success]="Company updated successfully."
	  	respond_to do |format|
				format.html
				format.js
	  	end
	  else
	  	render 'edit'
  	end
  end

  def destroy
  	@company = Company.find(params[:id])
  	@company.destroy
    @companies = Company.all
  	flash[:success]="Company deleted successfully."
    respond_to do |format|
      format.html
      format.js
    end
  end

  private

    def company_params
      params.require(:company).permit!
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
