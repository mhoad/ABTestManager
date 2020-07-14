class CustomerSignup
  include Interactor::Organizer

  organize CreateAccount, AddUserToAccount, AddUserRoleToAccount
end
