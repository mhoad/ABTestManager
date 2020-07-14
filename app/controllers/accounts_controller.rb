class AccountsController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :current_account, only: [:new, :create]

  def new
    @account = Account.new
  end

  def create
    result = CustomerSignup.call(account_params: account_params, user: current_user, role: :admin)
    if result.success?
      redirect_to account_dashboard_path(script_name: safe_account_script(result.account.slug))
    else
      flash.now[:message] = result.message
      render :new
    end
  end

  private

  def account_params
    params[:account].permit(:organization_name)
  end

  def safe_account_script(account_slug)
    "/#{'%07d' % account_slug}"
  end
end
