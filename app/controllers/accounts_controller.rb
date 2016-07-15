class AccountsController < ApplicationController

  alias_method :current_user, :current_vendor

  def index
    @accounts = Account.where(vendor_id: current_vendor.id)
  end

  def new
    @account = Account.new
  end

  def create
    @account = Account.new(accounts_params.merge(vendor_id: current_vendor.id))
    if @account.save
      flash[:info] = 'Account has been add!.'
      redirect_to accounts_path(@account)
    else
      flash[:warning] = 'Error! Please fill out all forms!'
      render 'new'
    end
  end

  private

  def accounts_params
    params.require(:account).permit(:name, :vendor_id)
  end

end