class ApplicationController < ActionController::Base
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :vendor_not_authorized
  layout :layout_by_resource
  protect_from_forgery with: :exception
  before_filter :authenticate_vendor!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  def configure_permitted_parameters
    if params[:customer]
      devise_parameter_sanitizer.for(:sign_up) << :email
    else
      devise_parameter_sanitizer.permit(:create) { |u| u.permit(:email, :admin, :vendor_name, :first_name, :last_name, :phone_number, :country, :state, :city, :zipcode, :web_site_url, :additional_information, :terms_and_condition, :business_address, :role, :sample_photo,category_ids: [], company_ids: [], channel_ids: []) }
      devise_parameter_sanitizer.permit(:account_update) do |u|
        u.permit( :email, :current_password, :password, :password_confirmation, :admin, :vendor_name, :first_name, :last_name, :phone_number, :country, :state, :city, :zipcode, :web_site_url, :additional_information, :terms_and_condition, :business_address, :sample_photo, :role)
      end
    end
  end

  def layout_by_resource
    if params["controller"] == "devise/registrations"
      "application"
    end
  end

  private

  def vendor_not_authorized
    flash[:danger] = 'Access denied.'
    redirect_to (request.referrer || authenticated_root_path)
  end
end
