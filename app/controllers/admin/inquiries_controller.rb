class Admin::InquiriesController < ApplicationController
  before_action :is_admin?
  def index
    @inquiries = Inquiry.all
  end

  def show
    @inquiry = Inquiry.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
    @inquiry = Inquiry.find(params[:id])
    @inquiry.destroy
    respond_to :js
  end
  private
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
