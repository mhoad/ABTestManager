module Accounts
  class SelectorController < ApplicationController
    before_action :authenticate_user!
    layout "marketing"
  
    def index
    end
  end
end