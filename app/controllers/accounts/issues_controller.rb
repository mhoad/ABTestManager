module Accounts
  class IssuesController < Accounts::BaseController
    def index
      @issues = current_account.issues.all
    end

    def show
      @issue = current_account.issues.find(params[:id])
    end
  end
end