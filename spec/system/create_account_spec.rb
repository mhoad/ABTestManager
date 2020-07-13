require 'rails_helper'

RSpec.describe "Create an account", type: :system do

  before do
    visit "/"
    click_link "Sign up"
    expect(current_path).to eq (new_user_registration_path)
  end

  scenario "with valid details" do
    fill_in "First name", with: "John"
    fill_in "Last name", with: "Smith"
    fill_in "Job title", with: "Owner"
    fill_in "Organization", with: "HyperGlobalMegaNet"
    fill_in "Email", with: "tester@example.tld"
    fill_in "Password", with: "test-password"
    fill_in "Password confirmation", with: "test-password"
    click_button "Sign up"

    expect(current_path).to eq new_account_path
    expect(page).to have_content("Welcome! You have signed up successfully.")

    click_button "Create"

    expect(current_path).to include account_dashboard_path
    expect(page).to have_content "HyperGlobalMegaNet"
  end

end