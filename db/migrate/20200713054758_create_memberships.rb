class CreateMemberships < ActiveRecord::Migration[6.0]
  def change
    create_table :memberships, id: :uuid do |t|
      t.references :account, null: false, foreign_key: true, type: :uuid
      t.references :user, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
