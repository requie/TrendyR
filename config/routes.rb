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
      root 'base/private/profiles#show', as: :authenticated_root
    end

    root to: 'devise/sessions#new'

    get 'users/password/recover' => 'users/passwords#password_recover_instructions', as: :recover
    post 'users/auth/registration' => 'users/omniauth_callbacks#create', as: :user_omniauth_register
    get 'admin/sign_in' => 'devise/sessions#new'
  end

  namespace :admin do
    post 'artists/featured_update' => 'artists#featured_update'
    post 'gigs/featured_update' => 'gigs#featured_update'
    resources :features, :dashboard, :artists, :gigs
  end

  scope module: :base do
    scope module: :public, as: :public do
      resources :profiles, only: :show, param: 'profile_id'
      resources :profiles, only: [] do
        resources :events, :awards, only: :index
        resources :gigs, only: :index
        resource :press_kit, only: :show
        resources :photo_albums, path: 'gallery', only: [:index, :show]
        resources :bookings, only: [:index, :create]
        resources :artists, only: :index
        resources :releases, only: :index
      end
    end

    scope module: :private, as: :private do
      resource :profiles, only: [:show, :update], path: '', as: :profile do
        patch :update_photo
        resource :press_kit, only: :show
      end

      resources :gigs, except: [:show, :destroy] do
        collection do
          delete :destroy
        end
      end

      resources :events, except: [:show, :destroy] do
        collection do
          delete :destroy
        end
      end

      resources :photo_albums, except: :destroy, path: 'gallery' do
        collection do
          delete :destroy
        end
      end

      resources :releases, except: :destroy, path: 'music' do
        collection do
          get :list
        end
      end

      resources :awards, except: :destroy do
        collection do
          delete :destroy
        end
      end

      resources :artists, only: :index

      resources :bookings, only: :index do
        member do
          put ':status' => :state, constraints: { status: /confirmed|rejected/ }, as: :status
          post 'request' => :request_confirmation
        end
      end
    end

    scope module: :resources do
      resources :gigs, :events, only: :show
      resource :settings, only: [:show, :update]
      resources :conversations, only: [:index, :show, :destroy] do
        collection do
          get ':recipient_id/new' => :new, as: :new
          post ':recipient_id/create' => :create, as: :create
        end
        member do
          post :update
        end
      end
      resources :photos, only: [:create, :destroy] do
        member do
          put 'crop/:preset' => 'photos#crop', as: :crop, constraints: { preset: /event_photo|avatar|wallpaper/ }
        end
      end
      resources :songs, only: [:create, :destroy] do
        member do
          put :publish
        end
      end
      resources :payments, path: 'payments', only: :index do
        collection do
          get 'event/:id' => :event_form, as: :ticket
          post 'event/:id' => :event_charge
        end
      end
    end
  end

  scope module: :guests do
    get ':page' => 'static_pages#index', as: :static_page, constraints: { page: /terms|faq|privacy|contact/ }

    resources :search, only: :index, shallow_path: 'search' do
      collection do
        get ':resource' => :search, as: :resource, constraints: { resource: /artist|label|venue|producer|manager/ }
        get :event
      end
    end

    resources :discovery, only: [] do
      collection do
        get ':resource' => :resource, constraints: { resource: /artists|labels|managers|producers|venues/ }, as: ''
        get :gigs, :events, :music
      end
    end
  end
end
