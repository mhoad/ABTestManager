Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html


  namespace :demo do
    root to: "main#dashboard"
    get '/issues', to: 'main#issues', as: 'issues'
    get '/issues/1', to: 'main#single_issue', as: 'issue'
    get '/hypotheses', to: 'main#hypotheses', as: 'hypotheses'
    get '/tests', to: 'main#tests', as: 'tests'
    get '/learnings', to: 'main#learnings', as: 'learnings'
    get '/tools', to: 'main#tools', as: 'tools'
    get '/team', to: 'main#team', as: 'team'
    get '/signup', to: 'main#signup', as: 'signup'
  end

  # scope "/:account_id", as: :account do
  #   root to: "demo/main#dashboard"

  #   resources :issues
  # end

  scope module: :demo do
    root to: "marketing#homepage"
  end
end
