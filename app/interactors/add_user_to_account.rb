class AddUserToAccount
  include Interactor

  def call
    check_required_params!

    if context.account.users.include? context.user
      context.fail!(message: "The user is already a member of this account.")
    else
      context.account.users << context.user
    end
  end

  private

  def check_required_params!
    context.fail!(message: "Please select a valid account.") if context.account.nil?
    context.fail!(message: "Please select a valid user.") if context.user.nil?
    context.fail!(message: "Please select a valid account.") unless context.account.is_a?(Account)
    context.fail!(message: "Please select a valid user.") unless context.user.is_a?(User)
  end
end
