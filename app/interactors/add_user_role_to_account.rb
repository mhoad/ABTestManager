class AddUserRoleToAccount
  include Interactor

  # Add specific Rolify role to a given user on a given account
  def call
    ensure_valid_params!

    context.user.add_role context.role.to_sym, context.account
  end

  private

  def ensure_valid_params!
    ensure_param_types!
    ensure_valid_role!
    ensure_valid_resources!
  end

  def ensure_valid_role!
    unless Role::VALID_ACCOUNT_ROLES.include? context.role.to_sym
      context.fail!(message: "Please select a valid role.")
    end
  end

  def ensure_param_types!
    context.fail!(message: "Please select a valid account.") unless context.account.is_a?(Account)
    context.fail!(message: "Please select a valid user.") unless context.user.is_a?(User)
    context.fail!(message: "Invalid role selected.") unless context.role.respond_to?(:to_sym)
  end

  def ensure_valid_resources!
    context.fail!(message: "Please select a valid account.") unless context.account.valid?
    context.fail!(message: "Please select a valid user.") unless context.user.valid?
  end
end
