require 'rails_helper'

describe Accounts::IssuePolicy do
  let(:user) { create :user }
  let(:context) { { user: user } }
  let(:account) { create(:account) }
  let!(:record) { create(:accounts_issue, { account: account } )}

  context "as a regular user not associated with the account" do
    describe_rule :show? do
      failed
    end

    describe_rule :edit? do
      failed
    end

    describe_rule :update? do
      failed
    end
  end

  context "as a user of the account" do
    before { AddUserToAccount.call(user: user, account: account) }

    context "with a :regular permission role" do
      before { AddUserRoleToAccount.call(user: user, account: account, role: :regular) }

      context "when the user owns the record" do
        before { record.user_id = user.id }

        describe_rule :show? do
          succeed
        end

        describe_rule :edit? do
          succeed
        end

        describe_rule :update? do
          succeed
        end
      end

      context "when the user does not own the record" do
        before { record.user_id = "123" }

        describe_rule :show? do
          succeed
        end

        describe_rule :edit? do
          failed
        end

        describe_rule :update? do
          failed
        end
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

      describe_rule :update? do
        succeed
      end
    end
  end
end
