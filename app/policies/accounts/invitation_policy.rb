module Accounts
  class InvitationPolicy < BasePolicy
    def new?
      user_is_account_member? && user_is_account_admin?
    end

    def create?
      user_is_account_member? && user_is_account_admin?
    end

    def accept?
      # You can't accept an account invite if you're already on the team
      !user_is_account_member?
    end

    def accepted?
      # You can't accept an account invite if you're already on the team
      !user_is_account_member?
    end
  end
end