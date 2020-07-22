require 'rails_helper'

describe Accounts::IssuePolicy do
  let(:user) { create :user }
  # `context` is the authorization context
  let(:context) { { user: user } }

  let(:account) { create(:account) }
  let!(:record) { create(:accounts_issue, { account: account, user: user } )}

  context "as a regular user not associated with the account" do
    describe_rule :show? do
      failed
    end
  end

  context "as a user of the account" do
    before { AddUserToAccount.call(user: user, account: account) }

    context "with a :regular permission role" do
      before { AddUserRoleToAccount.call(user: user, account: account, role: :regular) }

      describe_rule :show? do
        succeed
      end

      describe_rule :edit? do
        failed
      end
    end

    context "with an :admin permission role" do
      before { AddUserRoleToAccount.call(user: user, account: account, role: :admin) }

      describe_rule :show? do
        succeed
      end

      describe_rule :edit? do
        succeed
      end
    end
  end


  # describe_rule :show? do
  #   failed "for a user not associated with the account"

  #   succeed "when the user is associated with the account" do
  #     before { AddUserToAccount.call(user: user, account: account) }
  #   end
  # end

  # describe_rule :edit? do
  #   failed "for a user not associated with the account"

  #   context "user is associated with the account" do
  #     before { AddUserToAccount.call(user: user, account: account) }

  #     failed "if the user is not an account admin"

  #     succeed "when the user is an account admin" do
  #       before { AddUserRoleToAccount.call(user: user, account: account, role: :admin) }
  #     end
  #   end
  # end
end
