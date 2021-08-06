Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'current_users#me'

  devise_for :users
  namespace :api do
    scope :v1 do
      mount_devise_token_auth_for 'User', at: 'auth', controllers: {omniauth_callbacks: 'api/v1/omniauth_callbacks'}
       end
  end

  namespace :api do
    namespace :v1 do
      resources :todo_items, only: [:index, :show, :create, :update, :destroy]
    end
  end


  get '/me', to: 'current_users#me'
end
