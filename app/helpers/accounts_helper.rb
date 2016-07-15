module AccountsHelper
  def account_name(id)
    unless id.blank?
      account = Account.find(id)
      return account.name
    end
  end
end
