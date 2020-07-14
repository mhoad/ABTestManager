class ApplicationController < ActionController::Base

  private

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
