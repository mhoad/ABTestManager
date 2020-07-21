class ApplicationController < ActionController::Base

  private

  def current_account
    return nil if request.env['testmanager.account.slug'].nil?
    @current_account ||= Account.find_by(slug: request.env['testmanager.account.slug'])
  end
  helper_method :current_account

  def ensure_valid_account!
    if current_account.nil?
      flash[:notice] = "Please select a valid account before continuing."
      redirect_to account_selector_path(script_name: nil)
    end
  end
  helper_method :ensure_valid_account!
end
