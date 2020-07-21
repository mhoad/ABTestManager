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
module Accounts
  class Issue < ApplicationRecord
    belongs_to :account
    belongs_to :user

    validates :title, presence: true

    VALID_STATUS_OPTIONS = [:cancelled, :paused, :done, :in_progress].freeze
    VALID_PRIORITY_OPTIONS = [:low, :medium, :high, :critical].freeze
  end
end
