class ApplicationController < ActionController::Base
  # before_action :current_account

  # private

  def current_account
    @current_account ||= Account.find_by!(slug: request.env['testmanager.account.slug'])
  rescue ActiveRecord::RecordNotFound
    if user_signed_in?
      flash[:alert] = "The account you were looking for could not be found."
      redirect_to root_path(script_name: "/") # TODO: Find better place to send logged in users
    else
      redirect_to root_path(script_name: "/")
    end
  end
  helper_method :current_account
end
