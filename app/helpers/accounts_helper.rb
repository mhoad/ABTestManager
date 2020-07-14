module AccountsHelper
  def user_account_role(user: current_user, account: current_account)
    Role::VALID_ACCOUNT_ROLES.each do |role|
      return role if user.has_role? role, account
    end
  end
end
