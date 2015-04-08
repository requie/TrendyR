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
      root to: 'base/base#root', as: :authenticated_root
    end

    root to: 'devise/sessions#new'

    get 'users/password/recover' => 'users/passwords#password_recover_instructions', as: :recover
    post 'users/auth/registration' => 'users/omniauth_callbacks#create', as: :user_omniauth_register
    get 'admin/sign_in' => 'devise/sessions#new'
  end

  namespace :base, path: nil do
    resources :profile  do
      patch 'update_photo' => 'profile#update_photo', as: :update_photo
      resource :gallery
      resource :calendar
      resource :my_gigs
      resources :artists, :awards, :events, :gigs, :releases
      resources :photo_albums, except: :destroy
      delete 'destroy_photo_albums' => 'photo_albums#destroy'
      delete 'destroy_events' => 'events#destroy'
      resource :settings
    end
    put 'set_request_status/:id' => 'gigs#set_request_status', as: :set_request_status
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
      put 'crop/:preset' => 'photos#crop', as: :crop, constraints: { preset: /event_photo|avatar/i }
    end
  end
end
