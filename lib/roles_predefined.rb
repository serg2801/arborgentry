module RolesPredefined
  
class Init 

	    def get_roles_predefined	    		 
	    	
			role_vendor_default = {
			   "roles" => ["index", "show", "create_predefined"]   #example
			}
			
			role_vendor_admin = {
				"roles" => ["all"],
				"vendors" => ["all"],
				"accounts" => ["all"],
				"config_emails" => ["all"],
				"confirmations" => ["all"],
				"messages" => ["all"],
				"product_types" => ["all"],
				"static_page" => ["all"],
				"trade_forms" => ["all"],
				"vendor_forms" => ["all"],
				"vendor_onboarding_forms" => ["all"]
			}    	

	    	predefined_values = {       
		         
		         "admin" =>  {
		            'vendor_admin' =>  role_vendor_admin,
		            'vendor_default' => role_vendor_default
		         },
		         
		         "vendor_admin" => {
		         	'vendor_default' => role_vendor_default
		         }		        

		   }

		   return predefined_values.to_hash
		end
	
end

end
