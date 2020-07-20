class AccountInvitationMailer < ApplicationMailer
  def invite(invitation)
    @invitation = invitation
    mail(
      to: invitation.email,
      subject: "Invitation to join #{@invitation.account.organization_name} on Test Manager"
    )
  end
end
