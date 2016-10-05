class RolesController < ApplicationController
  alias_method :current_user, :current_vendor

  before_action :set_role, only: [ :show, :destroy ]
  before_action :set_roles, only: [ :index ]

  def index
    authorize Role
  end

  def show
    authorize Role
  end

  def new
    @role = Role.new
    authorize Role
  end

  def create
    if params['commit'].to_s == "Save"
      authorize Role
      @role = Role.new(name: params[:role]['name'], vendor_id: current_vendor.id)
      @permissions = params[:role][:permission_ids]
      unless @permissions.blank?
        @permissions.each do |permission|
          @permission = Permission.find(permission)
          @role.permissions << @permission
        end
      end
      if @role.save
        flash[:info] = 'Role has been successfully created!'
        redirect_to role_path(@role)
      else
        flash[:warning] = "Error! Please fill Role NMame field!"
        render 'new'
      end
    else
      redirect_to roles_path
    end 

  end

  def destroy
    authorize Role
    if @role.vendor_id == current_vendor.id
      @role.add_default_role
      @role.destroy
      set_roles
      flash[:success] = 'Role has been successfully deleted!'
      respond_to do |format|
        format.html
        format.js
      end
    else
      flash.now[:warning] = "You don't have access to perform current action!"
      redirect_to roles_path
    end
  end

  private
  #Before filters

    def set_role
      @role = Role.find(params[:id])
    end

    def set_roles
      @roles = Role.all
    end
    
end
