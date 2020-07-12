class CreateAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts do |t|
      t.string :organization_name, null: false
      t.integer :slug, null: false

      t.timestamps
    end

    add_index :accounts, :slug, unique: true
  end
end
