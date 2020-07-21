class CreateAccountsInvitations < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts_invitations, id: :uuid do |t|
      t.string :email, null: false
      t.references :account, null: false, foreign_key: true, type: :uuid
      t.string :token, null: false
      t.string :role, null: false

      t.timestamps
    end
    add_index :accounts_invitations, :token, unique: true
  end
end
