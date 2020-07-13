class CreateAccount
  include Interactor

  def call
    account = Account.new(context.account_params)
    if account.save
      context.account = account
    else
      context.fail!(message: account.errors)
    end
  end
end
