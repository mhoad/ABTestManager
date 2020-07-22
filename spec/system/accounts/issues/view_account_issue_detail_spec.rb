require "rails_helper"

RSpec.describe "Viewing a single account issues", type: :system do
  let(:admin_user) { create(:user) }
  let(:regular_user) { create(:user) }
  let(:account) { create(:account) }
  let!(:issue) { create(:accounts_issue, { account: account, user: admin_user } )}

  before do
    AddUserToAccount.call(user: admin_user, account: account, role: :admin)
    AddUserToAccount.call(user: regular_user, account: account, role: :regular)
    AddUserRoleToAccount.call(user: admin_user, account: account, role: :admin)
    AddUserRoleToAccount.call(user: regular_user, account: account, role: :regular)
  end

  context "as an account admin user" do
    before do
      sign_in admin_user
      visit account_prefix(issues_path)
      click_on(class: 'issue-card')
    end

    scenario "it shows the issue details correctly" do
      expect(page).to have_content issue.title
      expect(page).to have_content issue.user.first_name
      expect(page).to have_content issue.status.humanize
      expect(page).to have_content issue.priority.humanize
    end

    scenario "shows the edit button" do
      expect(page).to have_link "Edit Issue"
    end
  end

  context "as a regular user" do
    before do
      sign_in regular_user
      visit account_prefix(issues_path)
      click_on(class: 'issue-card')
    end

    scenario "it shows the details correctly" do
      expect(page).to have_content issue.title
      expect(page).to have_content issue.user.first_name
      expect(page).to have_content issue.status.humanize
      expect(page).to have_content issue.priority.humanize
    end

    scenario "does not show the edit button" do
      expect(page).to_not have_link "Edit Issue"
    end
  end

  private

  def account_prefix(path)
    "/#{AccountSlug.encode(account.slug)}#{path}"
  end
end