require "rails_helper"

RSpec.describe "Inviting users", type: :system do
  let(:account) { FactoryBot.create(:account) }
  let(:admin_user) { FactoryBot.create(:user) }
  let(:regular_user) { FactoryBot.create(:user) }

  before do
    AddUserToAccount.call(user: admin_user, account: account, role: :admin)
    AddUserToAccount.call(user: regular_user, account: account, role: :regular)
  end

  context "as an account admin user" do
    before do
      sign_in admin_user
      visit account_prefix(account_team_path)
    end

    scenario "creates an invitation successfully" do
      click_link "Add User"
      fill_in "Email", with: "test@example.com"
      click_button "Invite User"

      expect(page).to have_content "test@example.com was successfully invited."
      expect(current_path).to eq account_prefix(account_team_path)

      email = find_email("test@example.com")
      expect(email).to be_present
      expect(email.subject).to eq "Invitation to join #{account.organization_name} on Test Manager"
    end
  end

  private

  def account_prefix(path)
    "/#{AccountSlug.encode(account.slug)}#{path}"
  end
end
