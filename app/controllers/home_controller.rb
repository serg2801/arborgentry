class HomeController < ApplicationController
  alias_method :current_user, :current_vendor
  layout :resolve_layout
  before_filter :authenticate_vendor! , :except => [:welcome, :thank_you]
  def index
    latitude = request.location.data['latitude']
    longitude = request.location.data['longitude']
    forecast = ForecastIO.forecast(latitude, longitude)
    @config_emails = current_vendor.config_emails.first
    @vendor = Vendor.find(current_vendor.id)
    @vendor_form = @vendor.vendor_form
    @on_boarding = @vendor.vendor_onboarding_form
  end

  def login
  end

  def registration
  end

  def welcome
  end

  def thank_you
  end

  private
  def resolve_layout
    case action_name
    when "index"
      "application"
    when "welcome"
      "home"
    when "thank_you"
      "home"
    else
      "registration"
    end
  end
end
