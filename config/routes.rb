Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: %i[index show update destroy] do
        resources :recipes, only: %i[index show]
      end
      resources :recipes, only: %i[index show create update destroy]
    end
  end

  post '/signup', to: 'api/v1/users#create'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
end
