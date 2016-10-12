class RolesController < ApplicationController

  alias_method :current_user, :current_vendor

  before_action :do_authorize
  before_action :set_role, only: [ :show, :edit, :update, :create_predefined, :destroy ]
  before_action :set_roles, only: [ :index ]

  def index
    #
  end

  def show
    #
  end

  def update
    if params['commit'].to_s == "Save" 
      do_update
    else
      redirect_to roles_path
    end
  end

  def new
    if @role.nil?
      @role = Role.new
      set_permissions_for_role
    end    
  end

  def create
    do_create(nil)
  end

  def destroy
      if set_role_showonly(@role)
        flash[:danger] = "Current role cannot be deleted!" 
        set_roles 
      else
        destroy_group_of_owner(@role) 
        @role.destroy
        set_roles
        flash[:success] = 'Role has been successfully deleted!'
      end
      respond_to do |format|
        format.html
        format.js
      end
  end

  def create_predefined
    @cpr_roles = 0
    @cpr_groups = 0
    @cpr_permissions = 0
    create_predefined_roles
    if (@cpr_roles +  @cpr_groups + @cpr_permissions) == 0
      flash[:info] = "There are no new items to create!"
    else
      flash[:success] = "New items: #{@cpr_roles} role(s), #{@cpr_groups} group link(s), #{@cpr_permissions} permission(s)"
    end 
    redirect_to roles_path
  end  
  
  private

     def do_authorize
        authorize Role
        check_access        
     end 
     
     def init_predefined(vendor)
        @roles_predefined_owners = RolesPredefined::Init.new.get_roles_predefined
        res = -1
        @exist_predefined = ""
        all_keys = @roles_predefined_owners.keys
        unless all_keys.nil? || all_keys.blank?
          all_keys.each do |k|
            if @exist_predefined == ""
              if vendor.has_role?k
                 @exist_predefined = k.strip 
              end  
            end  
          end  
        end
     end

     def set_role_showonly(role)
       res = false
       unless role.nil?
         if (role.name == "admin") || !(current_vendor.has_role?("admin") || (role.vendor_id == current_vendor.id)) 
            role.updated_at = nil
            res = true
         end
       end
       return res
    end 

    def set_role
      @has_admin_access = current_vendor.has_role?("admin") 
      if !params[:id].nil? && (params[:id].to_i > 0)        
        @role = Role.find(params[:id])
        unless @role.nil? 
          set_role_showonly(@role)
          @all_available_permissions_count = 0
          set_permissions_for_role
        end          
      end
    end

    def set_roles
      if current_vendor.has_role?("admin") 
          @roles = Role.all
      else
          @roles = Role.where(vendor_id:  current_vendor.id)
          roles_ids = []
          unless @roles.nil? || @roles.blank?
            @roles.each do |r|
              roles_ids.push(r.id)
            end
          end
          Role.all.each do |r|
             if current_vendor.has_role?r.name 
                groups = RoleGroup.where(owner_id:  r.id) 
                unless groups.nil? || groups.blank?
                    groups.each do |g| 
                       unless (g.role_id == r.id) || roles_ids.include?(g.role_id)
                          role = Role.find(g.role_id)
                          unless role.nil? 
                              @roles << role
                              roles_ids.push(role.id)
                          end 
                       end                        
                    end
                end  
             end 
          end
      end  
      unless @roles.nil?
        @roles.map do |r|
          set_role_showonly(r)
        end  
      end
      init_predefined(current_vendor)
    end

    def set_permissions_for_role
      @all_available_permissions_count = Permission.where("updated_at is not null").count
      @role_available_permissions = []
      @role_permissions = []

      unless @role.nil?
        if  (@role.name == "admin") || current_vendor.has_role?("admin")
           all_p = Permission.where("updated_at is not null")
           unless all_p.nil?
              all_p.map do |p|
                @role_available_permissions.push(p.id)                
              end  
           end
        else         
           all_current_roles = []
           Role.all.each do |r|
             if current_vendor.has_role?r.name
                all_current_roles << r
             end  
           end 
           unless all_current_roles.blank?
              all_current_roles.map do |r|  
                 all_p = RolePermission.where(role_id: r.id) 
                 unless all_p.nil?
                    all_p.map do |p|
                      unless p.updated_at.nil? 
                        if !@role_available_permissions.include?(p.permission_id)
                          @role_available_permissions.push(p.permission_id)
                        end  
                      end
                    end 
                 end 
              end
           end           
        end
        unless @role.id.nil? 
          if @role.name == "admin"
              @role_available_permissions.each do |p|
                @role_permissions.push(p)
              end  
          else 
             all_p = RolePermission.where(role_id: @role.id)
             unless all_p.nil?
                  all_p.map do |p|
                    unless p.updated_at.nil? 
                      if @role_available_permissions.include?(p.permission_id)
                        @role_permissions.push(p.permission_id)
                      end  
                    end
                  end  
             end
          end
        end

      end 
    end

    def do_update      
      def do_update_and_redirect
        flash[:danger] = "Cannot find role to update!"
        redirect_to roles_path
      end       
      if params[:id].nil? || !(params[:id].to_i > 0)
        do_update_and_redirect
      else 
        role_to_update = Role.where(id: params[:id].to_i)
        if role_to_update.nil?
           do_update_and_redirect
        else  
          if set_role_showonly(@role)
            flash[:warning] = "Current role cannot be modified!"
            redirect_to roles_path
          else
            do_create(role_to_update[0]) 
          end  
        end   
      end 
    end  

    def do_create(target_role)
      if params['commit'].to_s == "Save"
        rname = params[:role]['name'].strip    
        if target_role.nil?     
          @role = Role.new(name: rname, vendor_id: current_vendor.id)
          set_permissions_for_role
        else
          @role = target_role
          old_name = @role.name
          @role.name = rname
        end  
        @role_permissions = []
        Permission.all.each do |permission|
          unless permission.updated_at.nil? 
              par = params["#{permission.id}_cb"]
              unless par.nil?
               #@role.permissions << permission
               @role_permissions << permission.id
              end  
          end  
        end 
        if rname == ""
          flash[:warning] = "Please fill Role Name field!"
          render "new" 
        else  
          if target_role.nil?
            unless Role.where(name: rname).count > 0              
                @role.permissions = []
                Permission.all.each do |permission|
                  if @role_permissions.include?permission.id
                     @role.permissions << permission 
                  end  
                end  
                if @role.save 
                  flash[:success] = 'Role has been successfully created!'
                else
                  flash[:danger] = "Error! Cannot create new role!"
                end
                redirect_to roles_path
            else
              flash[:warning] = "Role Name '#{rname}' already exists! Please enter another value"
              render "new" 
            end
          else  #update
            if !(old_name == rname) && (Role.where(name: rname).count > 0)
              flash[:warning] = "Role Name '#{rname}' already exists! Please enter another value"
              render "new" 
            else  
              RolePermission.where(role_id: @role.id).destroy_all
              @role.permissions = []
              Permission.all.each do |permission|
                if @role_permissions.include?permission.id
                    @role.permissions << permission 
                end  
              end  
              if @role.save 
                 flash[:success] = 'Role has been successfully updated!'
              else
                 flash[:danger] = "Error! Cannot update existing role!"
              end
              redirect_to roles_path
            end
          end 
        end
      else
        redirect_to roles_path
      end 
    end  


    def destroy_group_of_owner(role) 
      all_roles = RoleGroup.where("(owner_id = #{role.id}) or (role_id = #{role.id})")
      unless all_roles.nil? || all_roles.blank?
        all_roles.each do |r|
           r.destroy 
        end 
      end  
    end

    def create_predefined_roles(vendor_initiator = "")      
      def create_predefined_group(owner_role_id, role_id)
        unless  owner_role_id == role_id 
           if RoleGroup.where(owner_id: owner_role_id, role_id: role_id).count == 0
              RoleGroup.create(group_id: 0, owner_id: owner_role_id, role_id: role_id)
              @cpr_groups += 1 
           end 
        end 
      end 
      def create_predefined_role_permissions(role_id, controller_name, action_name)
         p_name = get_permission_name(controller_name, action_name)
         all_permissions = Permission.where("(name ='#{p_name}') and (updated_at is not null)")
         unless all_permissions.nil? 
            all_permissions.map do |p|
              if RolePermission.where(role_id: role_id, permission_id: p.id).count == 0
                  RolePermission.create(role_id: role_id, permission_id: p.id) 
                  @cpr_permissions += 1
              end 
            end  
         end
      end       
      if vendor_initiator == ""
         init_predefined(current_vendor) 
      else
         @exist_predefined = vendor_initiator
      end  
      if @exist_predefined == ""
        new_roles = nil
      else
        h = @roles_predefined_owners[@exist_predefined]
        new_roles = (h.nil?)?nil:h.to_hash
      end  
      unless new_roles.nil? || new_roles.blank? 
          owner_id = 0
          all_roles = Role.where(name: @exist_predefined)
          unless all_roles.nil? || all_roles.blank? 
             all_roles.each do |r|
               if owner_id == 0
                  owner_id = r.id
               end       
             end 
          end
          all_keys = new_roles.keys         
          sub_predefined_roles = []
          unless all_keys.nil? || all_keys.blank? || (owner_id == 0)
            all_keys.each do |new_role_name|
              unless new_role_name.nil? || (new_role_name.strip == "")
                sub_predefined_roles.push(new_role_name)
                all_roles = Role.where(name: new_role_name)
                role_ids = []
                unless all_roles.nil? || all_roles.blank?
                   all_roles.each do |r|
                      create_predefined_group(owner_id, r.id)
                      role_ids.push(r.id)
                   end 
                else  
                   role = Role.new(name: new_role_name, vendor_id: current_vendor.id) 
                   if role.save
                      create_predefined_group(owner_id, role.id)
                      role_ids.push(role.id)
                      @cpr_roles += 1
                   end            
                end
                #write permissions
                role_ids.each do |r|
                   controller_names = new_roles[new_role_name].to_hash
                   unless controller_names.nil? || controller_names.blank? 
                      all_c_names = controller_names.keys 
                      unless all_c_names.nil? || all_c_names.blank? 
                         all_c_names.each do |new_controller_name|
                           unless new_controller_name.strip == ""
                              all_actions = controller_names[new_controller_name]
                              all_actions.each do |a|
                                create_predefined_role_permissions(r, new_controller_name, a)
                              end  
                           end   
                         end 
                      end  
                   end 
                end
              end    
            end 
          end
          sub_predefined_roles.each do |r|
            create_predefined_roles(r)
          end  
      end 
    end  

 public

    def role_show_only?(role)
      return role.updated_at.nil?
    end  

end
