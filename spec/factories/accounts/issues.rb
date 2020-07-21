# == Schema Information
#
# Table name: accounts_issues
#
#  id         :uuid             not null, primary key
#  priority   :string
#  status     :string
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  account_id :uuid             not null
#  user_id    :uuid             not null
#
# Indexes
#
#  index_accounts_issues_on_account_id  (account_id)
#  index_accounts_issues_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :accounts_issue, class: 'Accounts::Issue' do
    title { "Something is broken" }
    priority { :high }
    status { :in_progress }
    account
    user
  end
end
