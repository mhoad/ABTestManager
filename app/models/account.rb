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
require 'securerandom'

class Account < ApplicationRecord
  before_validation :create_unique_slug, on: :create

  private

  def create_unique_slug
    self.slug = '%07d' % SecureRandom.rand(10 ** 7)
  end
end
