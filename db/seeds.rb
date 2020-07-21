# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user_one = User.create({
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  email: "user_1@example.com",
  password: "password",
  password_confirmation: "password",
  job_title: Faker::Job.title,
  organization: Faker::Company.name 
})

user_two = User.create({
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  email: "user_2@example.com",
  password: "password",
  password_confirmation: "password",
  job_title: Faker::Job.title,
  organization: Faker::Company.name 
})

user_three = User.create({
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  email: "user_3@example.com",
  password: "password",
  password_confirmation: "password",
  job_title: Faker::Job.title,
  organization: Faker::Company.name 
})

account_one = Account.create({
  organization_name: Faker::Company.name,
})

account_two = Account.create({
  organization_name: Faker::Company.name,
})

account_one.users << user_one << user_two
account_two.users << user_one << user_three

AddUserRoleToAccount.call(user: user_one, account: account_one, role: :admin )
AddUserRoleToAccount.call(user: user_two, account: account_one, role: :regular )
AddUserRoleToAccount.call(user: user_one, account: account_two, role: :regular )
AddUserRoleToAccount.call(user: user_three, account: account_two, role: :admin )


Accounts::Issue.create(title: "Product pages have multiple UX issues", priority: :high, account: account_one)
Accounts::Issue.create(title: "Add to cart button has low contrast", priority: :medium, account: account_one)
Accounts::Issue.create(title: "Icons don't show in internet explorer", priority: :medium, account: account_one)

Accounts::Issue.create(title: "JavaScript errors on the homepage", priority: :high, account: account_two)
Accounts::Issue.create(title: "Contact form is broken on mobile", priority: :low, account: account_two)
