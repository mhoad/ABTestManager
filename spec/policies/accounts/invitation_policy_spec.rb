require 'rails_helper'

describe Accounts::InvitationPolicy do
  let(:user) { create :user }
  let(:context) { { user: user } }
  let(:account) { create(:account) }
  let!(:record) { create(:accounts_invitation, { account: account } )}

  context "as a regular user not associated with the account" do
    describe_rule :new? do
      failed
    end

    describe_rule :create? do
      failed
    end

    describe_rule :accept? do
      succeed
    end

    describe_rule :accepted? do
      succeed
    end
  end

  context "as a user of the account" do
    before { AddUserToAccount.call(user: user, account: account) }

    context "with a :regular permission role" do
      before { AddUserRoleToAccount.call(user: user, account: account, role: :regular) }

      describe_rule :new? do
        failed
      end

      describe_rule :create? do
        failed
      end

      describe_rule :accept? do
        failed
      end
  
      describe_rule :accepted? do
        failed
      end
    end

    context "with an :admin permission role" do
      before { AddUserRoleToAccount.call(user: user, account: account, role: :admin) }

      describe_rule :new? do
        succeed
      end

      describe_rule :create? do
        succeed
      end

      describe_rule :accept? do
        failed
      end
  
      describe_rule :accepted? do
        failed
      end
    end
  end
end
