class AddStatusToAccountsIssues < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts_issues, :status, :string
  end
end
