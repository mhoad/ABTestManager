class MarketingPagesController < ApplicationController
  skip_before_action :current_account
  def homepage
  end
end
