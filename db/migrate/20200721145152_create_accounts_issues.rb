class CreateAccountsIssues < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts_issues, id: :uuid do |t|
      t.string :title, null: false
      t.string :priority
      t.references :account, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
