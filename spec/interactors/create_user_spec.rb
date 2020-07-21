require "rails_helper"

RSpec.describe CreateUser, type: :interactor do
  context "with valid attributes" do
    subject(:context) { CreateUser.call(user_params: attributes_for(:user)) }

    describe ".call" do
      it "succeeds" do
        expect(context).to be_a_success
      end

      it "provides a valid user" do
        expect(context.user).to be_a_kind_of(User)
        expect(context.user).to be_valid
      end
    end
  end

  context "with invalid attributes" do
    subject(:context) { CreateUser.call(user_params: nil) }

    describe ".call" do
      it "fails" do
        expect(context).to be_a_failure
      end
    end
  end
end
