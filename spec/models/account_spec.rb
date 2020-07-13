# == Schema Information
#
# Table name: accounts
#
#  id                :bigint           not null, primary key
#  organization_name :string           not null
#  slug              :integer          not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_accounts_on_slug  (slug) UNIQUE
#
require 'rails_helper'

RSpec.describe Account, type: :model do
  it "has a valid factory" do
    expect(build(:account)).to be_valid
  end

  let(:account) { build(:account) }

  context "database" do
    describe "columns" do
      it { should have_db_column(:organization_name).of_type(:string).with_options(null: false) }
      it { should have_db_column(:slug).of_type(:integer).with_options(null: false, unique: true) }
    end

    describe "indexes" do
      it { should have_db_index(:slug) }
    end
  end

  context "active record" do
    describe "validations" do
      it { should validate_presence_of(:organization_name) }
    end

    describe "associations" do
      it { expect(account).to have_many(:users) }
      it { expect(account).to have_many(:memberships) }
    end

    describe "callbacks" do
      it { expect(account).to callback(:create_unique_slug).before(:validation).on(:create) }
    end
  end
end
