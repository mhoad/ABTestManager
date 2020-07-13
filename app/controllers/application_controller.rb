class ApplicationController < ActionController::Base
  before_action :current_account

  private

  def current_account
    @current_account ||= Account.find_by!(slug: request.env['testmanager.account.slug'])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "The account you were looking for could not be found."
    redirect_to url_for(controller: 'marketing_pages', action: 'homepage', script_name: "/")
  end
  helper_method :current_account
end
