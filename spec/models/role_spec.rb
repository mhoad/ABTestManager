# == Schema Information
#
# Table name: roles
#
#  id            :uuid             not null, primary key
#  name          :string
#  resource_type :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  resource_id   :uuid
#
# Indexes
#
#  index_roles_on_name_and_resource_type_and_resource_id  (name,resource_type,resource_id)
#  index_roles_on_resource_type_and_resource_id           (resource_type,resource_id)
#
require 'rails_helper'

RSpec.describe Role, type: :model do
  context "database" do
    describe "columns" do
      it { should have_db_column(:id).of_type(:uuid).with_options(null: false) }
      it { should have_db_column(:name).of_type(:string) }
      it { should have_db_column(:resource_type).of_type(:string) }
      it { should have_db_column(:resource_id).of_type(:uuid) }
      it { should have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
      it { should have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }
    end

    describe "indexes" do
      # FIXME
      # it { should have_db_index(:name_and_resource_type_and_resource_id) }
      # it { should have_db_index(:resource_type_and_resource_id) }
    end
  end
end
