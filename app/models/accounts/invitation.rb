# == Schema Information
#
# Table name: accounts_invitations
#
#  id         :bigint           not null, primary key
#  email      :string           not null
#  role       :string           not null
#  token      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  account_id :bigint           not null
#
# Indexes
#
#  index_accounts_invitations_on_account_id  (account_id)
#  index_accounts_invitations_on_token       (token) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#
module Accounts
  class Invitation < ApplicationRecord
    belongs_to :account
    has_secure_token

    before_validation :symbolize_role

    validates :email, :role, presence: true
    validates :role, inclusion: { in: Role::VALID_ACCOUNT_ROLES.map(&:to_s),
    message: "%{value} is not a valid account role" }

    private

    def symbolize_role
      self.role = self.role.downcase.to_sym unless self.role.blank?
    end

  end
end
