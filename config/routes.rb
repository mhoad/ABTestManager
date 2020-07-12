Rails.application.routes.draw do
  devise_scope :user do
    get "/sign_in" => "users/sessions#new"
    get "/sign_up" => "users/registrations#new", as: "new_user_registration"
  end

  devise_for :users, controllers: { registrations: 'users/registrations' }

  root to: 'marketing_pages#homepage'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
