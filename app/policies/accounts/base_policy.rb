module Accounts
  class BasePolicy < ApplicationPolicy
    private

    def user_is_account_admin?
      user.has_role?(:admin, record.account)
    end

    def user_owns_record?
      record.user_id == user.id
    end

    def user_is_account_member?
      user.accounts.include? record.account
    end
  end
end