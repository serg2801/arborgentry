class OnBoardingFormMailer < ApplicationMailer
  default from: 'donotreply@tandemarbor.com'

  def sing_up_confirmation(on_boarding)
    @on_boarding = on_boarding
    attachments["#{@on_boarding.w_9_form}"] = File.read("#{Rails.root}/public/#{@on_boarding.w_9_form}") unless @on_boarding.w_9_form_url.nil?
    attachments["#{@on_boarding.certificate}"] = File.read("#{Rails.root}/public/#{@on_boarding.certificate}") unless @on_boarding.certificate_url.nil?
    mail to: 'trade@tandemarbor.com', subject:  'Vendor Onboarding Form ' + "#{@on_boarding.legal_business_name}"
  end

  def send_confirmation(on_boarding)
    @on_boarding = on_boarding
    mail to: on_boarding.primary_business_email,
         reply_to: 'vendors@tandemarbor.com',
         subject:  'Vendor Onboarding Form'
  end

  def update_on_boarding(on_boarding)
    @on_boarding = on_boarding
    attachments["#{@on_boarding.w_9_form}"] = File.read("#{Rails.root}/public/#{@on_boarding.w_9_form}") unless @on_boarding.w_9_form_url.nil?
    attachments["#{@on_boarding.certificate}"] = File.read("#{Rails.root}/public/#{@on_boarding.certificate}") unless @on_boarding.certificate_url.nil?
    mail to: 'trade@tandemarbor.com',
         subject:  'Update Vendor Onboarding Form' + "#{@on_boarding.legal_business_name}"
  end

end
