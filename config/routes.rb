Rails.application.routes.draw do
  namespace :v1 do
    post 'auth/login', to: 'authentication#authenticate'
    post 'signup', to: 'users#create'

    resources :todos do
      resources :items
    end
  end
end
