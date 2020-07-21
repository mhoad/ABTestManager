module Accounts
  class InvitationsController < Accounts::BaseController
    skip_before_action :authenticate_user!, only: [:accept, :accepted]
    skip_before_action :ensure_valid_account!, only: [:accept, :accepted]

    before_action :find_invitation, only: [:accept, :accepted]
    before_action :find_or_create_user, only: [:accepted]

    layout "marketing", only: [:accept]

    def new
      @invitation = current_account.invitations.new
    end

    def create
      result = InviteUserToAccount.call(invite_params: invitation_params, account: current_account)
      if result.success?
        redirect_to account_team_path, notice: "#{result.invitation.email} was successfully invited."
      else
        render :new
      end
    end

    def accept
      store_location_for(:user, request.fullpath)
    end

    def accepted
      result = AcceptInvitation.call(user: @user, account: @invitation.account, role: @invitation.role)

      if result.success?
        sign_in(result.user)

        flash[:notice] = "You have joined the #{result.account.organization_name} account."
        redirect_to account_scoped_path(account: result.account, path: account_dashboard_path)
      else
        flash[:alert] = "Sign in with an existing account if you have one."
        redirect_to accept_invitation_path(@invitation)
      end
    end

    private

    def find_or_create_user
      if user_signed_in?
        @user = current_user
      else
        result = CreateUser.call(user_params: user_params)
        @user = result.user if result.success?
      end
    end

    def find_invitation
      @invitation = Accounts::Invitation.find_by!(token: params[:id])
    end

    def invitation_params
      params[:accounts_invitation].permit(:email, :role)
    end

    def user_params
      params[:accounts_invitation].permit(
        :first_name, :last_name, :email, :password, :password_confirmation, :job_title, :organization
      )
    end
  end
end
