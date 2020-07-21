class CreateUser
  include Interactor

  def call
    user = User.new(context.user_params)
    if user.save
      context.user = user
    else
      context.fail!(message: user.errors)
    end
  end
end
