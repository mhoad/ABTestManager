require "rails_helper"

RSpec.describe AccountInvitationMailer, type: :mailer do
  let(:account) { FactoryBot.create(:account) }
  let(:invitation) { Accounts::Invitation.create(email: "test@example.com", account: account, role: :admin) }

  before do
    @email = AccountInvitationMailer.invite(invitation).deliver_now
  end

  it "should be set to be delivered to the email passed in" do
    expect(@email).to deliver_to("test@example.com")
  end

  it "should contain the user's message in the mail body" do
    expect(@email).to have_body_text("You have been invited")
  end

  it "should contain a link to the confirmation link" do
    expect(@email).to have_link("Accept Invitation")
  end

  it "should have the correct subject" do
    expect(@email).to have_subject("Invitation to join #{invitation.account.organization_name} on Test Manager")
  end
end
