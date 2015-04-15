class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :authenticate_vendor!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :admin, :vendor_name, :first_name, :last_name, :phone_number, :country, :state, :city, :zipcode, :web_site_url, :additional_information, :terms_and_condition, :business_address, category_ids: [], company_ids: [], channel_ids: [] ) }
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit( :email, :current_password, :password, :password_confirmation)
    end
  end
end
