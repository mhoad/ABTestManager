class ApplicationController < ActionController::Base
  rescue_from ActionPolicy::Unauthorized, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path(script_name: nil))
  end

  def current_account
    return nil if request.env["testmanager.account.slug"].nil?
    @current_account ||= Account.find_by(slug: request.env["testmanager.account.slug"])
  end
  helper_method :current_account

  def account_scoped_path(account: nil, path: nil)
    raise(ArgumentError, ":path must be a String") unless path.is_a?(String)
    return path if account.nil?

    raise(ArgumentError, ":account must be a Account") unless account.is_a?(Account)
    raise(ArgumentError, ":account must be a valid Account") unless account.valid?

    "/#{AccountSlug.encode(account.slug)}#{path}"
  end
  helper_method :account_scoped_path
end
