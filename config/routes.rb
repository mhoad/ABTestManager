Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "demo#dashboard"
  get '/issues', to: 'demo#issues', as: 'issues'
  get '/issues/1', to: 'demo#single_issue', as: 'issue'
  get '/hypotheses', to: 'demo#hypotheses', as: 'hypotheses'
  get '/tests', to: 'demo#tests', as: 'tests'
  get '/learnings', to: 'demo#learnings', as: 'learnings'
  get '/tools', to: 'demo#tools', as: 'tools'
  get '/team', to: 'demo#team', as: 'team'
end
