# == Schema Information
#
# Table name: accounts_invitations
#
#  id         :uuid             not null, primary key
#  email      :string           not null
#  role       :string           not null
#  token      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  account_id :uuid             not null
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
FactoryBot.define do
  factory :accounts_invitation, class: 'Accounts::Invitation' do
    sequence(:email) { |n| "person#{n}@example.com" }
    account
    token { "123456" }
    role { :admin }
  end
end
