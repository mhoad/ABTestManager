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
  context "database" do
    describe "columns" do
      it { should have_db_column(:organization_name).of_type(:string).with_options(null: false) }
      it { should have_db_column(:slug).of_type(:integer).with_options(null: false, unique: true) }
    end

    describe "indexes" do
      it { should have_db_index(:slug) }
    end
  end
end
