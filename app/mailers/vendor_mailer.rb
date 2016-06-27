class VendorMailer < ActionMailer::Base
	def send_admin_mail(vendor)
		@vendor = vendor
		mail(from: 'donotreply@tandemarbor.com', to: 'hello@tandemarbor.com', subject: 'New vendor registration')
	end

	def email_vandor_pass( vendor, password )
		@password = password
		@email   = vendor.email
		mail(from: 'donotreply@tandemarbor.com', to: @email, subject: 'Vendor password')
	end
end