require "rails_helper"

RSpec.describe "Viewing account team members", type: :system do
  let(:user_one) { create(:user) }
  let(:user_two) { create(:user) }
  let(:user_three) { create(:user) }
  let(:account) { create(:account) }

  before do
    AddUserToAccount.call(user: user_one, account: account, role: :admin)
    AddUserToAccount.call(user: user_two, account: account, role: :regular)
    sign_in user_one
    visit account_dashboard_path(script_name: "/#{AccountSlug.encode(account.slug)}")
    within ".list" do
      click_link "Team"
    end
  end

  scenario "shows correct team members" do
    expect(current_path).to eq account_prefix(account_team_path)
    expect(page).to have_content user_one.email
    expect(page).to have_content user_two.email
  end

  scenario "doesn't show other users" do
    expect(page).to_not have_content user_three.email
  end

  private

  def account_prefix(path)
    "/#{AccountSlug.encode(account.slug)}#{path}"
  end
end
