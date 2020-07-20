module Accounts
  class BaseController < ::ApplicationController
    before_action :authenticate_user!
    before_action :ensure_valid_account

  end
end