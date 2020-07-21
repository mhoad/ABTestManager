class AddUsersToAccountsIssues < ActiveRecord::Migration[6.0]
  def change
    add_reference :accounts_issues, :user, null: false, foreign_key: true, type: :uuid
  end
end
