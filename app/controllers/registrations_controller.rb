class RegistrationsController < Devise::RegistrationsController
  alias_method :current_user, :current_vendor
  
  #before_action :do_authorize

  layout 'application'

  protected

  def after_inactive_sign_up_path_for(resource)
    '/thank_you' # Or :prefix_to_your_route
  end

  private

  #def do_authorize
  #  check_access        
  #end 
  
end