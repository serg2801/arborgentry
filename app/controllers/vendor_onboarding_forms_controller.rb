class VendorOnboardingFormsController < ApplicationController

  skip_before_filter :authenticate_vendor!
  alias_method :current_user, :current_vendor

  layout 'vendor_form', only: [ :new, :create ]

  def index
    @on_boardings = VendorOnboardingForm.all
  end

  def show
    @on_boarding = VendorOnboardingForm.find(params[:id])
  end

  # def show
  #   @on_boarding = VendorOnboardingForm.find(params[:id])
  # end

  # def edit
  #   # @user = User.find(current_user.id)
  #   # @board = @user.board
  # end

  def new
    @on_boarding = VendorOnboardingForm.new
  end

  def create
    @on_boarding = VendorOnboardingForm.new(on_boarding_params)
    if @on_boarding.save
      OnBoardingFormMailer.sing_up_confirmation(@on_boarding).deliver
      OnBoardingFormMailer.send_confirmation(@on_boarding).deliver
      redirect_to vendor_onboarding_success_path
    else
      render 'new'
    end
  end

  # def update
  #   @user = User.find(current_user.id)
  #   # @on_boarding = @user.board
  #   if @on_boarding.update_attributes(on_boarding_params)
  #     # BoardMailer.update_board(@on_boarding).deliver
  #     redirect_to vendor_onboarding_success_update_path
  #   else
  #     render :edit
  #   end
  # end

  private

  def on_boarding_params
    params.require(:vendor_onboarding_form).permit(:legal_business_name, :company_name, :vendor_based_in, :vendor_based_in_other, :main_address_street, :main_address_unit, :main_address_city, :main_address_state,
                                  :main_address_zip, :main_address_country, :primary_business_name, :primary_business_phone, :primary_business_email, :primary_business_fax, :finance_name, :finance_phone,
                                  :finance_email, :finance_fax, :purchase_orders_name, :purchase_orders_phone, :purchase_orders_email, :purchase_orders_fax, :inventory_name, :inventory_phone,
                                  :inventory_email, :inventory_fax, :returns_name, :returns_phone, :returns_email, :returns_fax, :product_information_name, :product_information_phone,
                                  :product_information_email, :product_information_fax, :customer_service_name, :customer_service_phone, :customer_service_email, :customer_service_fax,
                                  :inventory_integration_method, :integrations_contact_name, :integrations_contact_phone, :integrations_contact_email, :integrations_contact_fax, :upc_marketing,
                                  :upc_ticketing_contact_name, :upc_ticketing_contact_phone, :upc_ticketing_contact_email, :upc_ticketing_contact_fax, :returns_contact_name, :returns_contact_phone,
                                  :returns_contact_email, :returns_contact_fax, :returns_address_street, :returns_address_unit, :returns_address_city, :returns_address_state, :returns_address_zip,
                                  :returns_address_country, :preferred_shipping_method, :protocol_for_freight_shipments, :multiple_warehouses, :shipping_from_multiple_warehouses,
                                  :transportation_and_shipment_section, :ship_alone_items, :average_inventory_levels, :typical_shipping_lead_time_count, :typical_shipping_lead_time_day,
                                  :average_inventory_replenishment_time_other, :method, :method_other, :frequency, :frequency_other, :credit_card, :wire_transfer, :check_by_mail,
                                  :bitcoin, :costs_fees, :if_so_costs_fees, :requirements_for_purchase_orders, :if_yes_requirements_for_purchase_orders, :imap_pricing, :return_policy, :merchandising,
                                  :average_inventory_replenishment_time_count, :average_inventory_replenishment_time_day, :costs_fees_radio, :w_9_form, :inventory_integration_method_other,
                                  :contact_other_title, :contact_other_name, :contact_other_phone, :contact_other_email, :contact_other_fax, :certificate,
                                                   onboarding_brands_attributes: [:id, :name, :vendor_onboarding_form_id, :_destroy],
                                                   onboarding_carriers_attributes: [:id, :name, :vendor_onboarding_form_id, :_destroy],
                                                   onboarding_product_types_attributes: [:id, :name, :vendor_onboarding_form_id, :_destroy],
                                                   onboarding_transportation_attributes: [:id, :vendor_onboarding_form_id, :ship_from_information_unit, :ship_from_information_city, :ship_from_information_state, :ship_from_information_zip,
                                                                            :ship_from_information_country, :transportation_contact_name, :transportation_contact_phone, :transportation_contact_email,
                                                                            :transportation_contact_fax, :ship_from_information_street, :_destroy])
  end

end
