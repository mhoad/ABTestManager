module Accounts
  class InvitationsController < Accounts::BaseController
    def new
      @invitation = current_account.invitations.new
    end

    def create
      @invitation = current_account.invitations.new(invitation_params)
      if @invitation.save
        redirect_to account_team_path, notice: "#{@invitation.email} was successfully invited."
      else
        render :new
      end
    end

    private

    def invitation_params
      params[:accounts_invitation].permit(:email, :role)
    end
  end
end