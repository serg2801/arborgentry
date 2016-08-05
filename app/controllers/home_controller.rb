class HomeController < ApplicationController
  alias_method :current_user, :current_vendor
  layout :resolve_layout
  before_filter :authenticate_vendor! , :except => [:welcome, :thank_you]
  before_filter :initialize_forecast, only: [ :index ]

  @@forecast = @@second_day = @@third_day = 'clear-day'

  def index
    @config_emails = current_vendor.config_emails.first
    @vendor = Vendor.find(current_vendor.id)
    @vendor_form = @vendor.vendor_form
    @on_boarding = @vendor.vendor_onboarding_form
  end

  def weather_params
    render status: 200, :json => {first_day_icon: @@forecast.currently.icon, second_day_icon: @@second_day.icon, third_day_icon: @@third_day.icon}
  end

  def map_city_visits
    @city = []
    @visit_city = VisitCity.all
    @visit_city.map { |city| @city << { latLng: [city.latitude, city.longitude], name: city.city, style: {fill: 'red', r: city.radius} } }
    render status: 200, :json => {mas_city: @city}
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
    when 'index'
      'application'
    when 'welcome'
      'home'
    when 'thank_you'
      'home'
    else
      'registration'
    end
  end

  def initialize_forecast
    begin
      @city = request.location.data['city']
      latitude = Geocoder.search(request.location.ip).first.latitude
      longitude = Geocoder.search(request.location.ip).first.longitude
      @forecast = ForecastIO.forecast( latitude, longitude, params: { units: 'si' } )
      # @forecast = ForecastIO.forecast( '50.0263','36.2174', params: { units: 'si' } )
      @@forecast = @forecast
      @second_day = @forecast.daily.data[2]
      @@second_day = @second_day
      second_weekday = DateTime.strptime("#{@second_day.time}",'%s')
      @second_weekday = second_weekday.strftime('%A')
      @third_day = @forecast.daily.data[3]
      @@third_day = @third_day
      third_weekday = DateTime.strptime("#{@third_day.time}",'%s')
      @third_weekday = third_weekday.strftime('%A')
      convert_to_fahrenheit(@forecast, @second_day, @third_day)
    rescue Exception => e
      puts ("#{e.message}")
    end
  end

  def convert_to_fahrenheit(today, second_day, third_day)
    @f_today = (9/5.0 * today.currently.temperature + 32).round(1)
    @f_second_day_min = (9/5.0 * second_day.temperatureMin + 32).round(1)
    @f_second_day_max = (9/5.0 * second_day.temperatureMax + 32).round(1)
    @f_third_day_min = (9/5.0 * third_day.temperatureMin + 32).round(1)
    @f_third_day_max = (9/5.0 * third_day.temperatureMax + 32).round(1)
  end
end
