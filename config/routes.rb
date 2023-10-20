Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'users', to: 'users#create'
      resources :secrets, param: :url
    end
  end
  post 'auth/login', to: 'sessions#login'
end
