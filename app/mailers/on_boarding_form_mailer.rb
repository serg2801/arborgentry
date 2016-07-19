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

  def create_user(on_boarding, user)
    @on_boarding = on_boarding
    @user = user
    @user_pas = decryption(user.pas_decrypt)
    mail to: @user.email,
         #      reply_to: "vendors@tandemarbor.com",
         subject:  'Vendor Onboarding Form'
  end

  def update_board(on_boarding)
    @on_boarding = on_boarding
    attachments["#{@on_boarding.w_9_form}"] = File.read("#{Rails.root}/public/#{@on_boarding.w_9_form}") unless @on_boarding.w_9_form_url.nil?
    attachments["#{@on_boarding.certificate}"] = File.read("#{Rails.root}/public/#{@board.certificate}") unless @on_boarding.certificate_url.nil?
    mail to: 'trade@tandemarbor.com',
         # reply_to: "vendors@tandemarbor.com",
         subject:  'Update Vendor Onboarding Form' + "#{@on_boarding.legal_business_name}"
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
