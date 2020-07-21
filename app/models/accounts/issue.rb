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
module Accounts
  class Issue < ApplicationRecord
    belongs_to :account

    validates :title, presence: true
  end
end
