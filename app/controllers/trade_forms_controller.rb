class TradeFormsController < ApplicationController

  skip_before_filter :authenticate_vendor!
  alias_method :current_user, :current_vendor

  layout 'vendor_form'

  def new
    @trade_form = TradeForm.new
  end

  def create
    binding.pry
    @trade_form = TradeForm.new(trade_forms_params)
    if @trade_form.save
      TradeFormMailer.sign_up_confirmation(@trade_form).deliver
      TradeFormMailer.send_confirmation(@trade_form).deliver
      redirect_to trade_success_path
    else
      render 'new'
    end
  end

  private
  def trade_forms_params
    params.require(:trade_form).permit(:business_name, :greeting, :first_name, :last_name, :email, :phone_number, :address,
                                   :suite, :city, :state, :zipcode, :country, :web_site_url, :information, :image,
                                   :certificate, :about_our_company, :describe_your_business, :tax_exempt, :dropship_e_commerce,
                                   :stocking_dealer, :non_stocking_dealer, :contract_details, :agree)
  end
end
