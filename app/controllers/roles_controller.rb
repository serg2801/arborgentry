class RolesController < ApplicationController
  
  alias_method :current_user, :current_vendor

  before_action :set_role, only: [ :show, :edit, :update, :destroy ]
  before_action :set_roles, only: [ :index ]

  def index
    authorize Role    
  end

  def show
    authorize Role
  end

  def update
    #authorize Role   
    do_update
  end

  def new
    if @role.nil?
      @role = Role.new
      set_permissions_for_role
    end
    authorize Role
  end

  def create
    authorize Role    
    do_create(nil) 
  end

  def destroy
    authorize Role
    #if @role.vendor_id == current_vendor.id
    #  @role.add_default_role
      @role.destroy
      set_roles
      flash[:success] = 'Role has been successfully deleted!'
      respond_to do |format|
        format.html
        format.js
      end
    #else
    #  flash.now[:warning] = "You don't have access to perform current action!"
    #  redirect_to roles_path
    #end
  end

  private
  #Before filters

    def set_role
      @role = Role.find(params[:id])
      @all_available_permissions = 0
      set_permissions_for_role      
    end

    def set_roles
      @roles = Role.all
    end

    def set_permissions_for_role
      @role_permissions = []
      unless @role.nil? || @role.id.nil?
         all_p = RolePermission.where(role_id: @role.id)
         unless all_p.nil?
            all_p.map do |p|
              unless p.updated_at.nil?
                @role_permissions.push(p.permission_id)
              end
            end  
         end
      end  
      #count
      Permission
      @all_available_permissions = Permission.where("updated_at not null").count
    end

    def do_update      
      def do_update_and_redirect
        flash[:warning] = "Cannot find role to update!"
        redirect_to roles_path
      end        
      if params[:id].nil? || !(params[:id].to_i > 0)
        do_update_and_redirect
      else 
        role_to_update = Role.where(id: params[:id].to_i)
        if role_to_update.nil?
           do_update_and_redirect
        else  
          do_create(role_to_update[0]) 
        end   
      end 
    end  

    def do_create(target_role)
      if params['commit'].to_s == "Save"
        rname = params[:role]['name'].strip    
        if target_role.nil?     
          @role = Role.new(name: rname, vendor_id: current_vendor.id)
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
                    @role.permissions << permission
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
                if @role.save 
                  flash[:info] = 'Role has been successfully created!'
                else
                  flash[:warning] = "Error! Cannot create new role!"
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
              if @role.save 
                 flash[:info] = 'Role has been successfully updated!'
              else
                 flash[:warning] = "Error! Cannot update existing role!"
              end
              redirect_to roles_path
            end
          end 
        end
      else
        redirect_to roles_path
      end 
    end  

end
