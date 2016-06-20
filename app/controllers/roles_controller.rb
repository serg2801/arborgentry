class RolesController < ApplicationController

  def index
    @roles = Role.where(vendor_id: current_vendor.id)
  end

  def show
    @role = Role.find(params[:id])
  end

  def new
    @role = Role.new
  end

  def create
    binding.pry
    @role = Role.new(name: params[:role]['name'], vendor_id: current_vendor.id)
    @permissions = params[:role][:permission_ids]
    @permissions.each do |permission|
      @permission = Permission.find(permission)
      @role.permissions << @permission
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
    @role = Role.find(params[:id])
    if @role.destroy
      flash[:success] = 'Role deleted successfully.'
      redirect_to roles_path
    end

  end


end
