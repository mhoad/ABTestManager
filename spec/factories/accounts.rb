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
FactoryBot.define do
  factory :account do
    organization_name { "HyperGlobalMegaNet" }
  end
end
