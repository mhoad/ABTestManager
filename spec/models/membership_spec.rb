# == Schema Information
#
# Table name: memberships
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  account_id :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_memberships_on_account_id  (account_id)
#  index_memberships_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Membership, type: :model do
  it "has a valid factory" do
    expect(build(:membership)).to be_valid
  end

  context "database" do
    describe "columns" do
      it { should have_db_column(:id).of_type(:integer).with_options(null: false) }
      it { should have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
      it { should have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }
      it { should have_db_column(:account_id).of_type(:integer).with_options(null: false) }
      it { should have_db_column(:user_id).of_type(:integer).with_options(null: false) }
    end
  end

  context "active record" do
    describe "associations" do
      it { should belong_to(:user) }
      it { should belong_to(:account) }
    end
  end
end
