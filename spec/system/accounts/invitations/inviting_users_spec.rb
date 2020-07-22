require "rails_helper"

RSpec.describe "Inviting users", type: :system do
  let(:account) { FactoryBot.create(:account) }
  let(:user) { FactoryBot.create(:user) }

  context "with a valid account" do
    context "as a user who isn't signed in" do
      scenario "I am unable to access the invitation page for an account" do
        visit account_prefix(new_invitation_path)

        expect(page).to have_content "You need to sign in or sign up before continuing."
        expect(current_path).to eq new_user_session_path
      end
    end

    context "as a signed in user" do
      before { sign_in user }
      context "who isn't a member of the account" do
        scenario "I am unable to access the invite page for this account" do
          visit account_prefix(new_invitation_path)

          expect(page).to have_content "Please select a valid account before continuing."
          expect(current_path).to eq account_selector_path
        end
      end
  
      context "as a member of the account" do
        before { AddUserToAccount.call(user: user, account: account) }

        context "with a :regular permissions role" do
          before { AddUserRoleToAccount.call(user: user, account: account, role: :regular) }

          scenario "I don't see the add user button" do
            visit account_prefix(account_team_path)

            expect(page).to_not have_link "Add User"
          end

          scenario "I am unable to access the invite page for this account" do
            visit account_prefix(new_invitation_path)

            expect(current_path).to eq account_prefix(account_team_path)
            expect(page).to have_content "You are not authorized to perform this action."
          end
        end
  
        context "with a :admin permissions role" do
          before { AddUserRoleToAccount.call(user: user, account: account, role: :admin) }

          scenario "I see the add user button" do
            visit account_prefix(account_team_path)

            expect(page).to have_link "Add User"
          end

          scenario "I am able to access the add user page for this account" do
            visit account_prefix(new_invitation_path)

            expect(current_path).to eq account_prefix(new_invitation_path)
            expect(page).to have_content "Invite a New User to Your Account"
          end

          context "using valid data" do
            scenario "I am able to invite a user successfully" do
              visit account_prefix(new_invitation_path)

              fill_in "Email", with: "test@example.com"
              click_button "Invite User"

              expect(page).to have_content "test@example.com was successfully invited."
              expect(current_path).to eq account_prefix(account_team_path)

              email = find_email("test@example.com")
              expect(email).to be_present
              expect(email.subject).to eq "Invitation to join #{account.organization_name} on Test Manager"
            end
          end

          context "using invalid data" do
            # FIXME: https://www.jorgemanrubia.com/2019/02/16/form-validations-with-html5-and-modern-rails/
            before { visit account_prefix(new_invitation_path) }

            # scenario "I am required to enter an email address" do
            #   click_button "Invite User"

            #   expect(page).to have_content "Email can't be blank"
            #   expect(current_path).to eq account_prefix(account_team_path)
            # end

            # scenario "It must enter a valid email address" do
            #   fill_in "Email", with: "this is clearly not an email"
            #   click_button "Invite User"

            #   expect(page).to have_content "Please enter a valid emaill adress"
            # end
          end
        end
      end
    end
  end

  private

  def account_prefix(path)
    "/#{AccountSlug.encode(account.slug)}#{path}"
  end
end
