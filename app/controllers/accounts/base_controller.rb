module Accounts
  class BaseController < ::ApplicationController
    before_action :authenticate_user!
    before_action :ensure_valid_account


    private

    # def current_account
    #   return if request.env['testmanager.account.slug'].nil?
    #     @current_account ||= Account.find_by!(slug: request.env['testmanager.account.slug'])
    #   rescue ActiveRecord::RecordNotFound
    #     if user_signed_in?
    #       flash[:alert] = "The account you were looking for could not be found."
    #       redirect_to account_selector_path(script_name: "/") # TODO: Find better place to send logged in users
    #     else
    #       redirect_to root_path(script_name: "/")
    #     end
    # end
    # helper_method :current_account

    def current_account
      return nil if request.env['testmanager.account.slug'].nil?
      @current_account ||= Account.find_by(slug: request.env['testmanager.account.slug'])
    end
    helper_method :current_account

    def ensure_valid_account
      !current_account.nil?
    end
    helper_method :ensure_valid_account
  end
end