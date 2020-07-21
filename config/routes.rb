Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "marketing_pages#homepage"

  devise_scope :user do
    get "/sign_in" => "users/sessions#new", :as => "sign_in"
    get "/sign_up" => "users/registrations#new", :as => "new_user_registration"
  end

  devise_for :users, controllers: {registrations: "users/registrations", sessions: "users/sessions"}

  get "/account/selector" => "accounts/selector#index", :as => :user_root
  get "/account/selector" => "accounts/selector#index", :as => "account_selector"

  get "/dashboard" => "accounts/dashboard#index", :as => "account_dashboard"
  get "/team" => "accounts/users#index", :as => "account_team"

  resources :invitations, only: [:new, :create], controller: "accounts/invitations" do
    member do
      get :accept
      patch :accepted
    end
  end

  resources :accounts_registration, only: [:new, :create], controller: "accounts/registrations"
end
