module Accounts
  class IssuePolicy < BasePolicy
    def show?
      user_is_account_member?
    end

    def edit?
      user_is_account_admin? || user_owns_record?
    end
  
    def update?
      user_is_account_admin? || user_owns_record?
    end
  end
end