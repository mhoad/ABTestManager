require 'rails_helper'

RSpec.describe "Accepting an account invitation", type: :system do
  let(:account) { FactoryBot.create(:account) }
  let(:invitation) { Accounts::Invitation.create(email: "test@example.com", account: account, role: :admin) }

  before do
    AccountInvitationMailer.invite(invitation).deliver_now
  end

  context "with a valid invite" do
    scenario "accepts an invitation" do
      email = open_email("test@example.com")
      accept_link = links_in_email(email).first
      
      expect(accept_link).to be_present
      visit accept_link
      # byebug
      fill_in "First name", with: "Old"
      fill_in "Last name", with: "Mate"
      fill_in "Password", with: "password"
      fill_in "Password confirmation", with: "password"
      fill_in "Job title", with: "Manager"
      fill_in "Organization", with: "Box Factory"

      click_button "Accept Invitation"

      expect(page).to have_content "You have joined the #{account.organization_name} account."
      expect(current_path).to eq account_prefix(account_dashboard_path)
      
      click_link "Team"
      expect(page).to have_content "Old Mate"
    end
  end

  private

  def account_prefix(path)
    "/#{AccountSlug::encode(account.slug)}#{path}"
  end
end