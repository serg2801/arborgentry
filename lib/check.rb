module Check
  class Verification
    def access(controller, current_vendor)
      case controller
        when 'spree/admin/products'
          unless check(:spree_products, current_vendor)
            vendor_not_authorized
          end
        when 'spree/admin/orders'
          unless check(:spree_orders, current_vendor)
            vendor_not_authorized
          end
        when 'spree/admin/return_index'
          unless check(:return_authorizations, current_vendor)
            vendor_not_authorized
          end
        when 'spree/admin/option_types'
          unless check(:option_types, current_vendor)
            vendor_not_authorized
          end
        when 'spree/admin/properties'
          unless check(:properties, current_vendor)
            vendor_not_authorized
          end
        when 'spree/admin/prototypes'
          unless check(:prototypes, current_vendor)
            vendor_not_authorized
          end
        when 'spree/admin/taxonomies'
          unless check(:taxonomies, current_vendor)
            vendor_not_authorized
          end
        when 'spree/admin/taxons'
          unless check(:taxons, current_vendor)
            vendor_not_authorized
          end
        when 'spree/admin/reports'
          unless check(:reports, current_vendor)
            vendor_not_authorized
          end
        when 'spree/admin/promotions'
          unless check(:promotions, current_vendor)
            vendor_not_authorized
          end
        when 'spree/admin/promotion_categories'
          unless check(:promotion_categories, current_vendor)
            vendor_not_authorized
          end
        when 'spree/admin/general_settings'
          unless check(:general_settings, current_vendor)
            vendor_not_authorized
          end
        when 'spree/admin/tax_categories'
          unless check(:tax_categories, current_vendor)
            vendor_not_authorized
          end
        when 'spree/admin/tax_rates'
          unless check(:tax_rates, current_vendor)
            vendor_not_authorized
          end
        when 'spree/admin/zones'
          unless check(:zones, current_vendor)
            vendor_not_authorized
          end
        when 'spree/admin/countries'
          unless check(:countries, current_vendor)
            vendor_not_authorized
          end
        when 'spree/admin/states'
          unless check(:states, current_vendor)
            vendor_not_authorized
          end
        when 'spree/admin/payment_methods'
          unless check(:payment_methods, current_vendor)
            vendor_not_authorized
          end
        when 'spree/admin/shipping_methods'
          unless check(:shipping_methods, current_vendor)
            vendor_not_authorized
          end
        when 'spree/admin/shipping_categories'
          unless check(:shipping_categories, current_vendor)
            vendor_not_authorized
          end
        when 'spree/admin/stock_transfers'
          unless check(:stock_transfers, current_vendor)
            vendor_not_authorized
          end
        when 'spree/admin/stock_locations'
          unless check(:stock_locations, current_vendor)
            vendor_not_authorized
          end
        when 'spree/admin/store_credit_categories'
          unless check(:store_credit_categories, current_vendor)
            vendor_not_authorized
          end
        when 'spree/admin/trackers'
          unless check(:trackers, current_vendor)
            vendor_not_authorized
          end
        when 'spree/admin/refund_reasons'
          unless check(:refund_reasons, current_vendor)
            vendor_not_authorized
          end
        when 'spree/admin/reimbursement_types'
          unless check(:reimbursement_types, current_vendor)
            vendor_not_authorized
          end
        when 'spree/admin/return_authorization_reasons'
          unless check(:return_authorization_reasons, current_vendor)
            vendor_not_authorized
          end
        else
          puts 'Access Success'
      end
    end

    def check(permission, current_vendor)
      current_vendor.roles.map { |r| r.has_permission?(permission) }.include? true or current_vendor.has_role? :admin or current_vendor.has_role? :vendor_admin
    end
  end
end