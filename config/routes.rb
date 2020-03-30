Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }

  get 'persons/profile'
  root 'main_page#index', as: 'home'

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

  resources :users do
    member do
      get :index
    end
    resources :collections do
      member do
        get :admin_edit
      end
      collection do
        get :admin_new
      end
      resources :items
    end
  end

  resources :posts
  resources :collections do
    resources :items
  end
  resources :comments

end
