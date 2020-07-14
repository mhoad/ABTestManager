require 'rails_helper'

RSpec.describe CustomerSignup, type: :interactor do
  it { expect(described_class.new).to be_kind_of(Interactor::Organizer) }
  it { expect(described_class.organized).to eq([CreateAccount, AddUserToAccount, AddUserRoleToAccount]) }
end
