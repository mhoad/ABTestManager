require 'rails_helper'

RSpec.describe AddUserRoleToAccount, type: :interactor do
  let(:user) { create(:user) }
  let(:account) { create(:account) }

  context "with valid attributes" do
    subject(:context) { AddUserRoleToAccount.call(account: account, user: user, role: :admin) }

    describe '.call' do
      it "succeeds" do
        expect(context).to be_a_success
      end

      it "adds the role to the user for the account" do
        expect(context.user.has_role? :admin, context.account).to be true
      end

      it "correctly scopes the user role" do
        expect(context.user.has_role? :admin, Account).to be false
        expect(context.user.has_role? :admin).to be false
      end
    end
  end

  context "with invalid attributes" do
    context "invalid role type" do
      subject(:context) { AddUserRoleToAccount.call(account: account, user: user, role: :fake_role) }
    
      describe '.call' do
        it "fails" do
          expect(context).to be_a_failure
        end

        it "does not add the role to the user for the account" do
          expect(context.user.has_role? :fake_role, context.account).to be false
        end

        it "does not add any roles" do
          expect(context.user.roles.blank?).to be true
        end
      end
    end

    context "missing role" do
      subject(:context) { AddUserRoleToAccount.call(account: account, user: user, role: nil) }

      describe '.call' do
        it "fails" do
          expect(context).to be_a_failure
        end
      end
    end

    context "missing account" do
      subject(:context) { AddUserRoleToAccount.call(account: nil, user: user, role: :admin) }

      describe '.call' do
        it "fails" do
          expect(context).to be_a_failure
        end
      end
    end

    context "missing user" do
      subject(:context) { AddUserRoleToAccount.call(account: account, user: nil, role: :admin) }

      describe '.call' do
        it "fails" do
          expect(context).to be_a_failure
        end
      end
    end
  end
end
