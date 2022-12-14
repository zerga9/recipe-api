Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: %i[index show update destroy] do
        resources :recipes, only: %i[index show]
        resources :ratings, only: %i[index show create update destroy]
      end
      resources :recipes, only: %i[index show create update destroy] do
        resources :ingredients, only: %i[index show create update destroy]
        resources :ratings, only: %i[index show create update destroy]
      end
    end
  end

  post '/signup', to: 'api/v1/users#create'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
end
