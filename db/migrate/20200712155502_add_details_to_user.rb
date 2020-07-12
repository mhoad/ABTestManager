class AddDetailsToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :first_name, :string, null: false
    add_column :users, :last_name, :string, null: false
    add_column :users, :job_title, :string, null: false
    add_column :users, :organization, :string, null: false
  end
end
