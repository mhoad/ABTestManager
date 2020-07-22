module Accounts
  class IssuePolicy < ApplicationPolicy
    # everyone can see any issue
    def show?
      user.accounts.include? record.account
    end

    def edit?
      user.has_role?(:admin, record.account)
    end
  
    def update?
      # `user` is a performing subject,
      # `record` is a target object (issue we want to update)
      # user.admin? || (user.id == record.user_id)
      user.has_role?(:admin, record.account)
    end
  end
end