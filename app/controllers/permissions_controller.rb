class PermissionsController < ApplicationController

alias_method :current_user, :current_vendor

before_action :do_authorize
before_action :set_constants
before_action :set_permissions, only: [ :index ]

def index 
  # 	
end

def save
	if params['commit'].to_s == "Save"
		save_autoPermissions
		transfer_autoPermissions
		flash[:success] = 'Your changes have been successfully saved!'
	else
	    flash[:info] = 'All changes have been cancelled!'	
	end
	redirect_to permissions_path
end

private

    def do_authorize
        authorize Permission
    end 

    def set_constants
    	@all_actions_alias = "--- All actions ---"
		@routes_denied = ["permissions", "registrations", "rails", "devise"]
		@routes_add_dirs = ["spree/admin", "spree/admin/orders"]
    end	

    def set_permissions	

		all_routes= Rails.application.routes.routes.map do |route|
  			{controller: route.defaults[:controller], action: route.defaults[:action]}
		end


		routes = []
		route_controllers = []
		all_routes.each do |r|
			 unless r[:controller].nil? || r[:action].nil?		
				  is_denied = false
				  s = r[:controller].to_s.downcase 
				  @routes_denied.each do |d|
				  		is_denied = is_denied || (s == d) || (s.index(d + "/") == 0) 
				  end	
				  unless is_denied	
						rnew = Hash.new
						rnew[:controller] = s
						rnew[:action] = r[:action].to_s.downcase						
						rnew[:alias] = rnew[:controller].gsub('/', '_') + "_" + rnew[:action]
						rnew[:description] = rnew[:action].capitalize + " " + rnew[:controller]	
						rnew[:sortflag] = get_permission_name(rnew[:controller], rnew[:action])
						routes << rnew
						unless route_controllers.include?(s)
				  			route_controllers << s
				 		 end
				  end	
				  	
			 end	
		end
		route_controllers.each do |c|
			rnew = Hash.new
			rnew[:controller] = c
			rnew[:action] = @all_actions_alias
			rnew[:alias] = "-"
			rnew[:description] = "-"
			rnew[:sortflag] = get_permission_name(c, @all_actions_alias)
			routes << rnew
			rnew = Hash.new
			rnew[:controller] = c
			rnew[:action] = 'all'
			rnew[:alias] = c.gsub('/', '_') + "_" + rnew[:action]
			rnew[:description] = "All_actions " + c
			rnew[:sortflag] = get_permission_name(c, @all_actions_alias + '_2')
			routes << rnew
		end	
		routes.uniq! { |r| r[:sortflag] }
		routes.sort_by! { |r| r[:sortflag] }
		@autopermissions = []
		routes.each do |r|
		    p = AutoPermission.new
			p.controller_name = r[:controller]
			p.alias = r[:alias]
			p.description = r[:description]
			p.action = r[:action]
			p.status = -1
			@autopermissions << p
		end	
		disabled_flag = 100
		AutoPermission.all.each do |p|
			found = false
    		@autopermissions.each do |permission|
    			if (p.controller_name == permission.controller_name) && (p.action == permission.action)
    				permission.id = p.id
    				permission.alias = p.alias
    				permission.description = p.description
    				found = true
    				status = p.status
    				unless status < disabled_flag - 1
    					status = status - disabled_flag
 						p.update_attributes(status: status)
 					end	
 					permission.status = p.status
    			end	
			end
			if !found 
				if p.status < disabled_flag
					p.update_attributes(status: p.status + disabled_flag)
				end
			end	
    	end
    	@saved_succesfully = true
    	@autopermissions.each do |permission|	
    	  if permission.id.nil? && (permission.status < 0)	
    		permission.save  
    		@saved_succesfully = false  	
    	  end			
    	end	
	end

	def transfer_autoPermissions

		def update_perm_attrs(perm, new_alias, new_description, new_status)
			case new_status
			  when 0
			  	u = nil
			  else
			  	u = Time.now
			end 
			#if perm.created_at.nil? || c.nil?  
			#   perm.update_attributes(description: new_description, key: new_alias, created_at: c, updated_at: u)
			#else	
			perm.update_attributes(description: new_description, key: new_alias, updated_at: u)
			#end   
		end
			
		permissions_passed = []
		AutoPermission.all.each do |p|
			unless (p.status < 0) || (p.action == @all_actions_alias)
				n = get_permission_name(p.controller_name, p.action)
				existing_permissions = Permission.where(name: n)
				unless existing_permissions.nil? || existing_permissions.blank?
					first_found = false
					existing_permissions.map do |ep|
						if first_found 
							ep.destroy
						else						
							permissions_passed.push(ep.id)
							first_found = true
							b1 = (ep.description == p.description)
							b3 = (ep.key == p.alias)
							b2 = ((ep.updated_at.nil? && (p.status == 0)) || (!(ep.updated_at.nil?) && (p.status > 0)))
							#b4 = ((ep.created_at.nil? && (p.status == 0)) || (!(ep.created_at.nil?) && (p.status > 0)))
							unless b1 && b2 && b3
								update_perm_attrs(ep, p.alias, p.description, p.status)
							end
						end	
					end				
				else
				  	if p.status > 0	
					  new_permission = Permission.create(name: n)	 
					  update_perm_attrs(new_permission, p.alias, p.description, p.status)
					  permissions_passed.push(new_permission.id)
				  	end
				end
			end
		end
		Permission.all.each do |p|
		  unless permissions_passed.include?(p.id) || p.updated_at.nil?
    		 p.update_attributes(updated_at: nil)    		
		  end	
		end	
	end	

	def save_autoPermissions
	   AutoPermission.all.each do |p|
	   	 param_p_alias = "#{p.id}_pa".to_sym
         p_alias = params[param_p_alias]
         param_p_descr = "#{p.id}_pd".to_sym
         p_descr = params[param_p_descr]
         param_p_status = "#{p.id}_ps".to_sym
         p_status = params[param_p_status]
         if p_status.nil? || (p_status.to_s == "")
         	p_status = -1
         end	
         unless p_alias.nil? || p_alias.blank? || p_descr.blank?
         	p.update_attributes(alias: p_alias, description: p_descr, status: p_status.to_i)
         end
	   end	
	end	

end
