Rails.application.routes.draw do

  # scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }

    get 'persons/profile'
    root 'main_page#index', as: 'home'

    get 'persons/profile', as: 'user_root'

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
        resources :items do
          collection do
            get :admin_new
          end
        end
      end
    end

    resources :posts
    resources :collections do
      resources :items do
        resources :comments 
        collection do 
          get :comments
        end
        member do
          put "like" => "items#upvote"
          put "unlike" => "items#downvote"
        end
      end
    end
    resources :tags, only: [:show]
    resources :search, only: [:index]

  # end
end
