class RolesController < ApplicationController

  before_action :set_role, only: [ :show, :destroy ]
  before_action :set_roles, only: [ :index ]

  def index
  end

  def show
  end

  def new
    @role = Role.new
  end

  def create
    @role = Role.new(name: params[:role]['name'], vendor_id: current_vendor.id)
    @permissions = params[:role][:permission_ids]
    unless @permissions.blank?
      @permissions.each do |permission|
        @permission = Permission.find(permission)
        @role.permissions << @permission
      end
    end
    if @role.save
      flash[:info] = 'Role has been add!.'
      redirect_to role_path(@role)
    else
      flash[:warning] = "Error! Please fill out all forms!"
      render 'new'
    end
  end

  def destroy
    if @role.vendor_id == current_vendor.id
      @role.add_default_role
      @role.destroy
      set_roles
      flash[:success] = 'Role deleted successfully.'
      respond_to do |format|
        format.html
        format.js
      end
    else
      flash.now[:warning] = "You have not access!"
      redirect_to roles_path
    end
  end

  private
  #Before filters

    def set_role
      @role = Role.find(params[:id])
    end
end
