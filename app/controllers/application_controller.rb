class ApplicationController < ActionController::Base
  include Pundit
  include CanCan::ControllerAdditions
  rescue_from Pundit::NotAuthorizedError, with: :vendor_not_authorized
  layout :layout_by_resource
  protect_from_forgery with: :exception
  # before_filter :access_spree
  before_filter :location_ip, except: [:weather_params, :map_city_visits]
  before_filter :authenticate_vendor!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  def configure_permitted_parameters
    if params[:customer]
      devise_parameter_sanitizer.for(:sign_up) << :email
    else
      devise_parameter_sanitizer.permit(:create) { |u| u.permit(:email, :admin, :vendor_name, :first_name, :last_name, :phone_number, :country, :state, :city, :zipcode, :web_site_url, :additional_information, :terms_and_condition, :business_address, :role, :permission, :sample_photo, category_ids: [], company_ids: [], channel_ids: []) }
      devise_parameter_sanitizer.permit(:account_update) do |u|
        u.permit(:email, :current_password, :password, :password_confirmation, :admin, :vendor_name, :first_name, :last_name, :phone_number, :country, :state, :city, :zipcode, :web_site_url, :additional_information, :terms_and_condition, :business_address, :sample_photo, :role, :permission)
      end
    end
  end

  def layout_by_resource
    if params["controller"] == 'devise/registrations'
      'application'
    end
  end

  private

  def vendor_not_authorized
    flash[:danger] = 'Access denied.'
    redirect_to (request.referrer || authenticated_root_path)
  end

  def set_roles
    @roles = Role.created_by_admin_and_current(current_vendor).uniq
  end

  def location_ip
    unless current_vendor
      begin
        geo_params = Geocoder.search(request.location.ip)
        location = geo_params.first.data
        Location.create(ip: location['ip'], country_name: location['country_name'], country_code: location['country_code'],
                        region_code: location['region_code'], zipcode: location['zipcode'], region_name: location['region_name'],
                        time_zone: location['time_zone'], latitude: location['latitude'], longitude: location['longitude'],
                        city: location['city'])
        city_visits(location)
      rescue Exception => e
        puts ("#{e.message}")
      end
    end
  end

  def city_visits(location)
    city = VisitCity.where(city: location['city'], country_name: location['country_name'])
    if city == []
      VisitCity.create(country_name: location['country_name'], latitude: location['latitude'], longitude: location['longitude'],
                       city: location['city'], count_visit: 1)
    else
      city.first.update_attributes(count_visit: (city.first.count_visit + 1))
    end

  end

  # def access_spree
  #   @controller =  params[:controller]
  #   case @controller
  #     when 'spree/admin/products'
  #       unless check(:spree_products)
  #         vendor_not_authorized
  #       end
  #     when 'spree/admin/orders'
  #       unless check(:spree_orders)
  #         vendor_not_authorized
  #       end
  #     when 'spree/admin/return_index'
  #       unless check(:return_authorizations)
  #         vendor_not_authorized
  #       end
  #     when 'spree/admin/option_types'
  #       unless check(:option_types)
  #         vendor_not_authorized
  #       end
  #     when 'spree/admin/properties'
  #       unless check(:properties)
  #         vendor_not_authorized
  #       end
  #     when 'spree/admin/prototypes'
  #       unless check(:prototypes)
  #         vendor_not_authorized
  #       end
  #     when 'spree/admin/taxonomies'
  #       unless check(:taxonomies)
  #         vendor_not_authorized
  #       end
  #     when 'spree/admin/taxons'
  #       unless check(:taxons)
  #         vendor_not_authorized
  #       end
  #     when 'spree/admin/reports'
  #       unless check(:reports)
  #         vendor_not_authorized
  #       end
  #     when 'spree/admin/promotions'
  #       unless check(:promotions)
  #         vendor_not_authorized
  #       end
  #     when 'spree/admin/promotion_categories'
  #       unless check(:promotion_categories)
  #         vendor_not_authorized
  #       end
  #     when 'spree/admin/general_settings'
  #       unless check(:general_settings)
  #         vendor_not_authorized
  #       end
  #     when 'spree/admin/tax_categories'
  #       unless check(:tax_categories)
  #         vendor_not_authorized
  #       end
  #     when 'spree/admin/tax_rates'
  #       unless check(:tax_rates)
  #         vendor_not_authorized
  #       end
  #     when 'spree/admin/zones'
  #       unless check(:zones)
  #         vendor_not_authorized
  #       end
  #     when 'spree/admin/countries'
  #       unless check(:countries)
  #         vendor_not_authorized
  #       end
  #     when 'spree/admin/states'
  #       unless check(:states)
  #         vendor_not_authorized
  #       end
  #     when 'spree/admin/payment_methods'
  #       unless check(:payment_methods)
  #         vendor_not_authorized
  #       end
  #     when 'spree/admin/shipping_methods'
  #       unless check(:shipping_methods)
  #         vendor_not_authorized
  #       end
  #     when 'spree/admin/shipping_categories'
  #       unless check(:shipping_categories)
  #         vendor_not_authorized
  #       end
  #     when 'spree/admin/stock_transfers'
  #       unless check(:stock_transfers)
  #         vendor_not_authorized
  #       end
  #     when 'spree/admin/stock_locations'
  #       unless check(:stock_locations)
  #         vendor_not_authorized
  #       end
  #     when 'spree/admin/store_credit_categories'
  #       unless check(:store_credit_categories)
  #         vendor_not_authorized
  #       end
  #     when 'spree/admin/trackers'
  #       unless check(:trackers)
  #         vendor_not_authorized
  #       end
  #     when 'spree/admin/refund_reasons'
  #       unless check(:refund_reasons)
  #         vendor_not_authorized
  #       end
  #     when 'spree/admin/reimbursement_types'
  #       unless check(:reimbursement_types)
  #         vendor_not_authorized
  #       end
  #     when 'spree/admin/return_authorization_reasons'
  #       unless check(:return_authorization_reasons)
  #         vendor_not_authorized
  #       end
  #     else
  #       puts 'Access Success'
  #   end
  # end
  #
  #
  # def check(permission)
  #   current_vendor.roles.map { |r| r.has_permission?(permission) }.include? true or current_vendor.has_role? :admin or current_vendor.has_role? :vendor_admin
  # end

end
