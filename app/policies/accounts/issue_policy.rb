module Accounts
  class IssuePolicy < ApplicationPolicy
    def show?
      user.accounts.include? record.account
    end

    def edit?
      (user.has_role?(:admin, record.account)) || (record.user_id == user.id)
    end
  
    def update?
      user.has_role?(:admin, record.account) || (record.user_id == user.id)
    end
  end
end