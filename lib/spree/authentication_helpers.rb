module Spree
  module CurrentUserHelpers
    def self.included(receiver)
      receiver.send :helper_method, :spree_current_user
    end

    def spree_current_user
      current_vendor
    end
  end

  module AuthenticationHelpers
    def self.included(receiver)
      receiver.send :helper_method, :spree_login_path
      receiver.send :helper_method, :spree_signup_path
      receiver.send :helper_method, :spree_logout_path
    end

    def spree_login_path
      '/vendors/sign_in'
    end

    def spree_signup_path
      '/vendors/sign_up'
    end

    def spree_logout_path
      '/vendors/sign_out'
    end
  end
end

ApplicationController.send :include, Spree::AuthenticationHelpers
ApplicationController.send :include, Spree::CurrentUserHelpers

Spree::Api::BaseController.send :include, Spree::CurrentUserHelpers
