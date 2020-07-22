module Accounts
  class BaseController < ApplicationController
    before_action :authorize_user!

    private


    def user_not_authorized
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to(request.referrer || account_selector_path)
    end

    def authorize_user!
      unless authenticate_user! && ensure_account_membership!
        flash[:notice] = "Please select a valid account before continuing."
        redirect_to account_selector_path(script_name: nil)
      end
    end

    def ensure_account_membership!
      return false if current_account.nil?
      current_account.users.include? current_user
    end
  end
end
