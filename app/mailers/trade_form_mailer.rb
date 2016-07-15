class TradeFormMailer < ApplicationMailer
  default from: 'donotreply@tandemarbor.com'

  def sign_up_confirmation(trade_form)
    @trade_form = trade_form
    attachments["#{@trade_form.image}"] = File.read("#{Rails.root}/public/#{@trade_form.image}") unless @trade_form.image_url.nil?
    mail to: 'trade@tandemarbor.com', subject:  'Trade Form Submission ' + "#{@trade_form.business_name}"
  end

  def send_confirmation(trade_form)
    @trade_form = trade_form
    mail to: trade_form.email,
         reply_to: 'trade@tandemarbor.com',
         subject:  'Trade Form Submission'
  end
end
