require "rails_helper"

RSpec.describe "Viewing account issues list", type: :system do
  let(:user) { create(:user) }
  let(:account) { create(:account) }
  let(:account_two) { create(:account) }
  let!(:issue) { create(:accounts_issue, { account: account, user: user, title: "Account 1 Issue" })}
  let!(:issue_two) { create(:accounts_issue, { account: account_two, user: user, title: "Account 2 Issue" })}


  before do
    AddUserToAccount.call(user: user, account: account, role: :admin)

    sign_in user
    visit account_prefix(account_dashboard_path)
    within ".list" do
      click_link "Issues"
    end
  end

  scenario "shows correct team issues" do
    expect(current_path).to eq account_prefix(issues_path)
    expect(page).to have_content "Account 1 Issue"
  end

  scenario "doesn't show other users" do
    expect(page).to_not have_content "Account 2 Issue"
  end

  private

  def account_prefix(path)
    "/#{AccountSlug.encode(account.slug)}#{path}"
  end
end
