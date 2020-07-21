require "rails_helper"

# Specs in this file have access to a helper object that includes
# the AccountsHelper. For example:
#
# describe AccountsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe AccountsHelper, type: :helper do
  let(:user) { create(:user) }
  let(:account) { create(:account) }

  before do
    AddUserRoleToAccount.call(user: user, account: account, role: :admin)
  end

  it "returns the correct role name" do
    expect(helper.user_account_role(user: user, account: account)).to eq :admin
  end
end
