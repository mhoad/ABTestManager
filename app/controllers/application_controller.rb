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

  def account_scoped_path(account: nil, path: "nil")
    raise(ArgumentError, ":path must be a String") unless path.is_a?(String)
    return path if account.nil?

    raise(ArgumentError, ":account must be a Account") unless account.is_a?(Account)
    raise(ArgumentError, ":account must be a valid Account") unless account.valid?
    
    return "/#{AccountSlug::encode(account.slug)}#{path}"
  end
  helper_method :account_scoped_path
end
