require "rails_helper"

RSpec.describe CreateAccount, type: :interactor do
  context "with valid attributes" do
    subject(:context) { CreateAccount.call(account_params: attributes_for(:account)) }

    describe ".call" do
      it "succeeds" do
        expect(context).to be_a_success
      end

      it "provides a valid account" do
        expect(context.account).to be_a_kind_of(Account)
        expect(context.account).to be_valid
      end
    end
  end

  context "with invalid attributes" do
    subject(:context) { CreateAccount.call(account_params: nil) }

    describe ".call" do
      it "fails" do
        expect(context).to be_a_failure
      end
    end
  end
end
