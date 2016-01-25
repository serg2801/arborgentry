class VendorMailer < ActionMailer::Base
	def send_admin_mail(vendor)
		@vendor = vendor
		mail(from: @vendor.email, to: 'hello@tandemarbor.com', subject: 'New vendor registration')
	end
end