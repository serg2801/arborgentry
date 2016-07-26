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

  def create_vendor(vendor_form, user)
    @vendor_form = vendor_form
    @user = user
    @user_pas = decryption(user.pas_decrypt)
    mail to: @user.email,
         subject:  '[LOGIN] Tandem Arbor Vendors'
  end

  def update_vendor_form(vendor_form)
    @vendor_form = vendor_form
    @vendor_form_options = VendorForm.find(@vendor_form.id).option_forms
    @vendor_form_categories = VendorForm.find(@vendor_form.id).category_forms
    @vendor_form_channels = VendorForm.find(@vendor_form.id).channel_forms
    attachments["#{@vendor_form.image}"] = File.read("#{Rails.root}/public/#{@vendor_form.image}") unless @vendor_form.image_url.nil?
    mail to: 'trade@tandemarbor.com',
         subject:  'Update Vendor Form' + "#{@vendor_form.business_name}"
  end

  private

  def decryption(password)
    cipher = OpenSSL::Cipher.new('AES-128-ECB')
    cipher.decrypt()
    cipher.key = ENV["key_encrypt_decrypt"]
    tempkey = Base64.decode64(password)
    crypt = cipher.update(tempkey)
    crypt << cipher.final()
    return crypt
  rescue Exception => exc
    puts ("Message for the decryption log file for message #{password} = #{exc.message}")
  end

end
