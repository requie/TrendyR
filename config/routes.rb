Rails.application.routes.draw do
  devise_for :users, controllers: {
    confirmations: 'users/confirmations',
    passwords: 'users/passwords',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  devise_scope :user do
    authenticated :user, ->(user) { user.role?(:admin) } do
      root to: 'admin/dashboard#index', as: :admin_root
    end

    authenticated :user, ->(user) { user.role.is_public? } do
      root 'base/profiles#index', as: :authenticated_root
    end

    root to: 'devise/sessions#new'

    get 'users/password/recover' => 'users/passwords#password_recover_instructions', as: :recover
    post 'users/auth/registration' => 'users/omniauth_callbacks#create', as: :user_omniauth_register
    get 'admin/sign_in' => 'devise/sessions#new'
  end

  namespace :base, path: nil do
    resource :profile, only: :update do
      get '/' => :index
      patch :update_photo, as: :update_photo

      resource :settings, only: [:show, :update]
      resources :galleries, path: 'gallery', only: :index
      resources :events, except: :show do
        collection do
          delete :destroy
        end
      end
      resources :photo_albums, except: [:index, :show, :destroy] do
        collection do
          delete :destroy
        end
      end
      resources :photo_albums, only: [] do
        member do
          get '/' => :private_show
        end
      end

      resources :gigs, except: :show do
        member do
          put :state, as: :status
        end
      end

      resources :awards, except: [:show, :destroy] do
        collection do
          delete :destroy
        end
      end
    end

    resources :profiles, path: 'profile', only: :show, as: :public_profile do
      resource :events, :gallery, only: :show
      resource :gigs, only: :show, as: :public_gigs do
        member do
          get '/:id' => :overview, as: :overview
        end
      end
      resources :photo_albums, only: :show, as: :public_photo_album
      resource :awards, only: :show, as: :publick_awards

      resources :bookings, only: [:index, :create]

      resources :artists, :releases
    end
  end

  namespace :admin do
    post 'artists/featured_update' => 'artists#featured_update'
    post 'gigs/featured_update' => 'gigs#featured_update'
    resources :features
    resources :dashboard, :artists, :gigs
  end

  # Test routes for uploads, must remove it before rolling out to production
  resources :uploads

  resources :photos, only: [:create, :destroy] do
    member do
      put 'crop/:preset' => 'photos#crop', as: :crop, constraints: { preset: /event_photo|avatar|wallpaper/i }
    end
  end

  resources :songs, only: [:create, :destroy]
end
