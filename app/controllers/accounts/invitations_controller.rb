module Accounts
  class InvitationsController < Accounts::BaseController
    skip_before_action :authenticate_user!, only: [:accept, :accepted]
    skip_before_action :ensure_valid_account, only: [:accept, :accepted]

    layout "marketing", only: [:accept]

    def new
      @invitation = current_account.invitations.new
    end

    def create
      @invitation = current_account.invitations.new(invitation_params)
      if @invitation.save
        AccountInvitationMailer.invite(@invitation).deliver_later
        redirect_to account_team_path, notice: "#{@invitation.email} was successfully invited."
      else
        render :new
      end
    end

    def accept
      @invitation = Accounts::Invitation.find(params[:id])
    end

    def accepted
      # byebug
      @invitation = Accounts::Invitation.find(params[:id])
      user = User.create!(user_params)
      @invitation.account.users << user
      AddUserRoleToAccount.call(user: user, account: @invitation.account, role: @invitation.role.to_sym)
      sign_in(user)
      flash[:notice] = "You have joined the #{@invitation.account.organization_name} account."
      redirect_to account_dashboard_path(script_name: "/#{AccountSlug::encode(@invitation.account.slug)}")
    end

    private

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