class AccountsController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :current_account, only: [:new, :create]

  def new
    @account = Account.new
  end

  def create
    @account = Account.new(account_params)
    if @account.save
      redirect_to (url_for controller: 'dashboard', action: 'index', script_name: "/#{@account.slug}" )
    else
      render :new
    end
  end

  private

  def account_params
    params[:account].permit(:organization_name)
  end
end
