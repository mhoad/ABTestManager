# == Schema Information
#
# Table name: accounts_issues
#
#  id         :uuid             not null, primary key
#  priority   :string
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  account_id :uuid             not null
#
# Indexes
#
#  index_accounts_issues_on_account_id  (account_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#
FactoryBot.define do
  factory :accounts_issue, class: 'Accounts::Issue' do
    title { "Something is broken" }
    priority { "High" }
    account
  end
end
