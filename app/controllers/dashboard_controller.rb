class DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_valid_account!

  def index
  end
end
