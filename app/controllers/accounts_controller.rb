class AccountsController < ApplicationController
  before_action :authenticate_user!

  def new
    @account = Account.new
  end

  def create
    result = CustomerSignup.call(account_params: account_params, user: current_user, role: :admin)
    if result.success?
      redirect_to account_dashboard_path(script_name: "/#{AccountSlug::encode(result.account.slug)}")
    else
      flash.now[:message] = result.message
      render :new
    end
  end

  private

  def account_params
    params[:account].permit(:organization_name)
  end
end
