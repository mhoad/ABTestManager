module Accounts
  class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :current_account

    def index
    end
  end
end
