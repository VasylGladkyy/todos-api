Rails.application.routes.draw do
  namespace :v1 do
    resources :todos do
      resources :items
    end
  end
end
