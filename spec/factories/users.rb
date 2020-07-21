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
FactoryBot.define do
  factory :user do
    first_name { "John" }
    last_name { "Smith" }
    job_title { "Owner" }
    organization { "HyperGlobalMegaCorp" }
    sequence(:email) { |n| "person#{n}@example.com" }
    password { "qwerty" }
  end
end
