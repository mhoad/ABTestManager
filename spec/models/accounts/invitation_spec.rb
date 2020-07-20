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
require 'rails_helper'

RSpec.describe Accounts::Invitation, type: :model do
  it "has a valid factory" do
    expect(build(:accounts_invitation)).to be_valid
  end

  let(:invitation) { build(:accounts_invitation) }

  context "database" do
    describe "columns" do
      it { should have_db_column(:email).of_type(:string).with_options(null: false) }
      it { should have_db_column(:role).of_type(:string).with_options(null: false) }
      it { should have_db_column(:token).of_type(:string).with_options(null: false, unique: true) }
      it { should have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
      it { should have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }
      it { should have_db_column(:account_id).of_type(:integer).with_options(null: false) }
    end

    describe "indexes" do
      it { should have_db_index(:token) }
      it { should have_db_index(:account_id) }
    end
  end

  context "active record" do
    describe "validations" do
      it { should validate_presence_of(:email) }
      it { should validate_presence_of(:role) }
    end

    describe "associations" do
      it { should belong_to(:account) }
    end
  end

  context "behaviour" do
    describe "secure token" do
      it "generates correctly" do
        invitation.save
        expect(invitation.token).to be_present
      end
    end
  end
end
