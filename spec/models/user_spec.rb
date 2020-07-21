# == Schema Information
#
# Table name: users
#
#  id                     :uuid             not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string           not null
#  job_title              :string           not null
#  last_name              :string           not null
#  organization           :string           not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
require "rails_helper"

RSpec.describe User, type: :model do
  it "has a valid factory" do
    expect(build(:user)).to be_valid
  end

  let(:user) { build(:user) }

  context "database" do
    describe "columns" do
      it { should have_db_column(:first_name).of_type(:string).with_options(null: false) }
      it { should have_db_column(:last_name).of_type(:string).with_options(null: false) }
      it { should have_db_column(:job_title).of_type(:string).with_options(null: false) }
      it { should have_db_column(:organization).of_type(:string).with_options(null: false) }
      it { should have_db_column(:remember_created_at).of_type(:datetime) }
      it { should have_db_column(:reset_password_sent_at).of_type(:datetime) }
      it { should have_db_column(:reset_password_token).of_type(:string) }
    end

    describe "indexes" do
      it { should have_db_index(:email) }
      it { should have_db_index(:reset_password_token) }
    end
  end

  context "active record" do
    describe "validations" do
      it { should validate_presence_of(:first_name) }
      it { should validate_presence_of(:last_name) }
      it { should validate_presence_of(:job_title) }
      it { should validate_presence_of(:organization) }
      it { should validate_presence_of(:email) }
      it { should validate_presence_of(:password) }
    end

    describe "associations" do
      it { expect(user).to have_many(:accounts) }
      it { expect(user).to have_many(:memberships) }
    end
  end
end
