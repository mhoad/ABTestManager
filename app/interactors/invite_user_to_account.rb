class InviteUserToAccount
  include Interactor

  def call
    ensure_valid_params!

    invitation = context.account.invitations.new(context.invite_params)
    if invitation.save
      context.invitation = invitation
      AccountInvitationMailer.invite(invitation).deliver_later
    else
      context.fail!(message: invitation.errors)
    end
  end

  private

  def ensure_valid_params!
    context.fail!(message: "Invalid invitation parameters.") unless context.invite_params.is_a?(ActionController::Parameters)
    context.fail!(message: "Please select a valid account.") unless context.account.is_a?(Account)
  end
end
