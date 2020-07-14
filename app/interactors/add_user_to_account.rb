class AddUserToAccount
  include Interactor

  def call
    ensure_valid_params!

    if context.account.users.include? context.user
      context.fail!(message: "The user is already a member of this account.")
    else
      context.account.users << context.user
    end
  end

  private

  def ensure_valid_params!
    context.fail!(message: "Please select a valid account.") unless context.account.is_a?(Account)
    context.fail!(message: "Please select a valid user.") unless context.user.is_a?(User)
  end
end
