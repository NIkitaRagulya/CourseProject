Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }

  get 'persons/profile'
  root 'posts#index', as: 'home'

  get 'persons/profile', as: 'user_root'

  # get 'online' => 'pages#online_users', as:'online_users'
  # delete 'online/:id', to: 'pages#destroy', as:'user'

  resources :online_users, only: [:index, :destroy, :update] do
    collection do 
      delete :delete_users
      put :ban_users
      put :unlock_users
      put :set_admin
    end
  end

  resources :posts
  resources :collections
  resources :items
  resources :comments

end
