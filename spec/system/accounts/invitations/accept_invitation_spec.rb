require "rails_helper"

RSpec.describe "Accepting an account invitation", type: :system do
  let(:account) { FactoryBot.create(:account) }

  context "with a valid invitation" do
    let(:invitation) { Accounts::Invitation.create(email: "test@example.com", account: account, role: :admin) }

    before { visit accept_invitation_path(invitation) }
      
    context "as a new user without an existing account" do
      let(:user_attributes) { FactoryBot.attributes_for(:user) }

      context "when entering valid data" do
        before do
          fill_in "First name", with: user_attributes[:first_name]
          fill_in "Last name", with: user_attributes[:last_name]
          fill_in "Password", with: user_attributes[:password]
          fill_in "Password confirmation", with: user_attributes[:password]
          fill_in "Job title", with: user_attributes[:job_title]
          fill_in "Organization", with: user_attributes[:organization]
        end

        scenario "I can accept an invitation" do
          click_button "Accept Invitation"

          expect(page).to have_content "You have joined the #{account.organization_name} account."
        end

        scenario "I am redirected to the account dashboard" do
          click_button "Accept Invitation"

          expect(current_path).to eq account_prefix(account_dashboard_path)
        end

        scenario "I am added to the account correctly" do
          click_button "Accept Invitation"

          expect(User.first.accounts.first).to eq account
          expect(account.users.first.first_name).to eq user_attributes[:first_name]
        end

        scenario "I am assigned the correct permissions on the account" do
          click_button "Accept Invitation"

          expect(User.first.has_role?(invitation.role, invitation.account)).to eq true
          expect(User.first.has_role?(invitation.role)).to eq false
        end
      end

      context "when entering invalid data" do
        # TODO
      end
  
    end
  
    context "as an existing user" do
      let!(:existing_user) { FactoryBot.create(:user) }

      context "when not already signed in" do
        before { visit accept_invitation_path(invitation) }

        scenario "filling out the form prompts me to sign in instead" do
          fill_in "First name", with: existing_user.first_name
          fill_in "Last name", with: existing_user.last_name
          fill_in "Email", with: existing_user.email
          fill_in "Password", with: existing_user.password
          fill_in "Password confirmation", with: existing_user.password
          fill_in "Job title", with: existing_user.job_title
          fill_in "Organization", with: existing_user.organization

          click_button "Accept Invitation"

          expect(page).to have_content "Sign in with an existing account if you have one."
          expect(current_path).to eq accept_invitation_path(invitation)
        end

        scenario "the form shows me an option to sign in" do
          expect(page).to have_link "Sign in as an existing user"
        end

        context "when signing in to accept the invitation" do
          before do
            click_link "Sign in as an existing user"

            fill_in "Email", with: existing_user.email
            fill_in "Password", with: existing_user.password
            click_button "Log in"
          end

          scenario "I am redirected back to the correct page" do
            expect(current_path).to eq accept_invitation_path(invitation)
          end

          scenario "I am no longer prompted to sign in" do
            expect(page).to_not have_content("Sign in as an existing user")
          end

          scenario "I can just click a single button to accept the invitation" do
            click_button "Accept Invitation"

            expect(page).to have_content "You have joined the #{account.organization_name} account."
            expect(current_path).to eq account_prefix(account_dashboard_path)
          end
        end
      end
  
      context "when already signed in" do
        before { sign_in existing_user}

        scenario "I can accept an invitation without entering any information" do
          click_button "Accept Invitation"

          expect(page).to have_content "You have joined the #{account.organization_name} account."
          expect(current_path).to eq account_prefix(account_dashboard_path)
        end
      end

      context "when already a member of the account" do
        #TODO
      end
    end
  end

  context "with an invalid invitation" do
    scenario "an invitation can not be used twice" do
      #TODO
    end

    scenario "an invalid account won't work" do
      #TODO
    end

    scenario "an invalid role won't work" do
      #TODO
    end
  end

  private

  def account_prefix(path)
    "/#{AccountSlug.encode(account.slug)}#{path}"
  end
end
