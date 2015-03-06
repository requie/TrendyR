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

    authenticated :user do
      root to: 'base/base#index', as: :authenticated_root
    end

    get 'users/password/recover' => 'users/passwords#password_recover_instructions', as: :recover
    post 'users/auth/registration' => 'users/omniauth_callbacks#create', as: :user_omniauth_register
    get 'admin/sign_in' => 'devise/sessions#new'
  end

  root to: 'devise/sessions#new'

  patch 'home/:id/edit' => 'base/home#update',as: :update_base_home

  namespace :base, path: nil do
    resources :home
    resources :gigs, :awards, except: :show
    get 'profiles/:id/artists' => 'artists#show', as: :artists
    get 'profiles/:id/awards' => 'awards#show', as: :awards_show
    get 'profiles/:id/calendar' => 'calendar#show', as: :calendar
    get 'profiles/:id/events' => 'events#show', as: :events
    get 'profiles/:id/gallery' => 'gallery#show', as: :gallery
    get 'profiles/:id/gigs' => 'gigs#show', as: :gigs_show
    get 'profiles/:id/releases' => 'releases#show', as: :releases
  end

  namespace :admin do
    post 'artists/featured_update' => 'artists#featured_update'
    post 'gigs/featured_update' => 'gigs#featured_update'
    resources :features
    resources :dashboard, :artists, :gigs
  end

  # Test routes for uploads, must remove it before rolling out to production
  resources :uploads

  resources :photos, only: [:new, :create] do
    member do
      put 'crop'
    end
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
