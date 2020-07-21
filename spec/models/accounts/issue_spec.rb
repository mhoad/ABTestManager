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
require 'rails_helper'

RSpec.describe Accounts::Issue, type: :model do
  it "has a valid factory" do
    expect(build(:accounts_issue)).to be_valid
  end

  context "database" do
    describe "columns" do
      it { should have_db_column(:priority).of_type(:string) }
      it { should have_db_column(:title).of_type(:string).with_options(null: false) }
      it { should have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
      it { should have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }
      it { should have_db_column(:account_id).of_type(:uuid).with_options(null: false) }
    end

    describe "indexes" do
      it { should have_db_index(:account_id) }
    end
  end

  context "active record" do
    describe "validations" do
      it { should validate_presence_of(:title) }
    end

    describe "associations" do
      it { should belong_to(:account) }
    end
  end
end
