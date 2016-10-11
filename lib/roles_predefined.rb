module RolesPredefined
  
class Init 

	    def get_roles_predefined	    		 
	    	
			role_vendor_default = {
			   "roles" => ["index", "show"] 
			}
			
			role_vendor_admin = {
				"roles" => ["index", "show", "edit"],
				"vendors" => ["all"]
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
