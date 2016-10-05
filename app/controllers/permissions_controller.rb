class PermissionsController < ApplicationController

alias_method :current_user, :current_vendor

before_action :set_constants
before_action :set_permissions, only: [ :index ]
before_action :is_admin?

def index
  	#authorize Permission
end

def save
	if params['commit'].to_s == "Save"
		save_autoPermissions
		transfer_autoPermissions
	end
	redirect_to permissions_path
end

private

	def is_admin?
      if current_vendor
        unless current_vendor.admin?
          flash[:danger]="You have no rights"
          redirect_to(authenticated_root_path)
        end
      else
        redirect_to(new_vendor_session_path)
      end
    end

    def set_constants
    	@all_actions_alias = "--- All actions ---"
		@routes_denied = ["permissions"]
    end	

    def set_permissions	
		all_routes= Rails.application.routes.routes.map do |route|
  			{alias: route.name, path: route.path.spec.to_s, controller: route.defaults[:controller], action: route.defaults[:action]}
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
						rnew[:alias] = rnew[:controller] + " # " + rnew[:action]
						routes << rnew
				  end	
				  unless route_controllers.include?(s)
				  	route_controllers << s
				  end	
			 end	
		end
		route_controllers.each do |c|
			rnew = Hash.new
			rnew[:controller] = c
			rnew[:action] = @all_actions_alias
			rnew[:alias] = rnew[:controller] + " # " + rnew[:action]
			routes << rnew
		end	
		routes.uniq! { |r| r[:alias] }
		routes.sort_by! { |r| r[:alias] }
		@autopermissions = []
		routes.each do |r|
		    p = AutoPermission.new
			p.controller_name = r[:controller]
			p.action = r[:action]
			p.alias = r[:alias]
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
    				found = true
    				status = p.status
    				unless status < disabled_flag
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

		def update_perm_attrs(perm, new_alias, new_status)
			case new_status
			  when 0
			  	c = nil
			  	u = Time.now
			  when 1
			  	c = Time.now
			  	u = nil
			  else
			  	c = Time.now
			  	u = Time.now
			end 
			if perm.created_at.nil? || c.nil?  
			   perm.update_attributes(description: new_alias, created_at: c, updated_at: u)
			else	
			   perm.update_attributes(description: new_alias, updated_at: u)
			end   
		end
			
		AutoPermission.all.each do |p|
			unless (p.status < 0) || (p.action == @all_actions_alias)
				existing_permissions = Permission.where(name: p.controller_name, key: p.action)
				unless existing_permissions.nil? || existing_permissions.blank?
					first_found = false
					existing_permissions.map do |ep|
						if first_found 
							ep.destroy
						else						
							first_found = true
							b1 = (ep.description == p.alias)
							b2 = ((ep.updated_at.nil? && (p.status == 1)) || (!(ep.updated_at.nil?) && (p.status > 1)))
							b3 = ((ep.created_at.nil? && (p.status == 0)) || (!(ep.created_at.nil?) && (p.status > 0)))
							unless b1 && b2 && b3
								update_perm_attrs(ep, p.alias, p.status)
							end
						end	
					end				
				else
				  	if p.status > 0	
					  new_permission = Permission.create(name: p.controller_name, description: "",  key: p.action)	 
					  update_perm_attrs(new_permission, p.alias, p.status)
				  	end
				end	
			end
		end	
	end	

	def save_autoPermissions
	   AutoPermission.all.each do |p|
	   	 param_p_alias = "#{p.id}_pa".to_sym
         p_alias = params[param_p_alias]
         #p "Alias for #{p.id}:  #{p_alias}"
         param_p_status = "#{p.id}_ps".to_sym
         p_status = params[param_p_status]
         #p "Value for #{p.id}:  #{p_status}"
         if p_status.nil? || (p_status.to_s == "")
         	p_status = -1
         end	
         unless p_alias.nil? || p_alias.blank? 
         	p.update_attributes(alias: p_alias, status: p_status.to_i)
         end
	   end	
	end	

end
