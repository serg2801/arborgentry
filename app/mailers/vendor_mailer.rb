class VendorMailer < ActionMailer::Base
	def send_admin_mail(vendor)
		@vendor = vendor
		mail(from: 'donotreply@tandemarbor.com', to: 'hello@tandemarbor.com', subject: 'New vendor registration')
	end
end