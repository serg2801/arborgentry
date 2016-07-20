class VendorFormMailer < ApplicationMailer
  default from: 'donotreply@tandemarbor.com'

  def sing_up_confirmation(vendor_form)
    @vendor_form = vendor_form
    attachments["#{@vendor_form.image}"] = File.read("#{Rails.root}/public/#{@vendor_form.image}") unless @vendor_form.image_url.nil?
    mail to: 'trade@tandemarbor.com', subject:  'Vendor Form Submission ' + "#{@vendor_form.business_name}"
  end

  def send_confirmation(vendor_form)
    @vendor_form = vendor_form
    mail to: vendor_form.email,
         reply_to: 'vendors@tandemarbor.com',
         subject:  'Vendor Form Submission'
  end

end
