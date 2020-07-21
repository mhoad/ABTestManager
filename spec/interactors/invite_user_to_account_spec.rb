require 'rails_helper'

RSpec.describe InviteUserToAccount, type: :interactor do
  context "with valid attributes" do
    let(:account) { FactoryBot.create(:account) }

    subject(:context) { InviteUserToAccount.call(invite_params: attributes_for(:accounts_invitation), account: account ) }

    describe '.call' do
      it "succeeds" do
        expect(context).to be_a_success
      end

      it "provides a valid user" do
        expect(context.invitation).to be_a_kind_of(Accounts::Invitation)
        expect(context.invitation).to be_valid
      end
    end
  end
end
