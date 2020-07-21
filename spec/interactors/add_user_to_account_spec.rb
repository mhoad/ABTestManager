require "rails_helper"

RSpec.describe AddUserToAccount, type: :interactor do
  let(:user) { create(:user) }
  let(:account) { create(:account) }

  context "with valid attributes" do
    subject(:context) { AddUserToAccount.call(account: account, user: user) }

    describe ".call" do
      it "succeeds" do
        expect(context).to be_a_success
      end

      it "adds the user to the account" do
        expect(context.account.users.include?(user)).to be true
      end

      it "adds the account to user.accounts" do
        expect(context.user.accounts.include?(account)).to be true
      end
    end

    context "when the user is already an account member" do
      before do
        AddUserToAccount.call(account: account, user: user)
      end

      subject(:context) { AddUserToAccount.call(account: account, user: user) }

      describe ".call" do
        it "fails" do
          expect(context).to be_a_failure
          expect(context.message).to eq "The user is already a member of this account."
        end
      end
    end
  end

  context "with invalid parameters" do
    context "missing account parameter" do
      subject(:context) { AddUserToAccount.call(account: nil, user: user) }

      describe ".call" do
        it "fails" do
          expect(context).to be_a_failure
        end
      end
    end

    context "missing user parameter" do
      subject(:context) { AddUserToAccount.call(account: account, user: nil) }

      describe ".call" do
        it "fails" do
          expect(context).to be_a_failure
        end
      end
    end
  end
end
