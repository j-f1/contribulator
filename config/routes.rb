Rails.application.routes.draw do
  get '/about' => 'pages#about'
  get '/api' => 'pages#api'

  namespace :api do
    jsonapi_resources :projects
  end

  get 'issues/:id' => 'issues#show', as: :issue

  get 'projects/new' => 'projects#new', as: :new_project
  get 'projects/confirm' => 'projects#confirm', as: :project_confirm
  post 'projects' => 'projects#create', as: :projects
  get 'projects' => 'projects#index', as: :project_index
  get 'projects/:id' => 'projects#show', as: :project

  get '/login',  to: 'sessions#new',     as: 'login'
  get '/logout', to: 'sessions#destroy', as: 'logout'

  get '/search', to: 'search#index', as: :project_search
  match '/auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  post '/auth/failure',             to: 'sessions#failure'

  get '/:user' => 'users#show', as: :user
  match '/:user/:repo', to: 'projects#show', via: [:get], as: :project_direct, constraints: { repo: /[^\/]+/ }

  root 'projects#index'
end
