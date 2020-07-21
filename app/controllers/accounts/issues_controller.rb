module Accounts
  class IssuesController < Accounts::BaseController
    def index
      @issues = current_account.issues.all
    end
  end
end