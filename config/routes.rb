Rails.application.routes.draw do
  devise_for :users, controllers: {
    # sessions: "users/sessions",
    omniauth_callbacks: 'users/omniauth_callbacks'
  }, skip: [:sessions]
  # devise_for :users, :controllers => { :registrations => 'registrations', :omniauth_callbacks => "authentications" }, :skip => [:sessions]

# to add still:
# path: '/', constraints: { subdomain: 'api' }

   namespace :api, defaults: { format: :json } do
      resources :users, only: [:show, :update, :destroy] do 
        resource :user_profile, except: :destroy
        resource :company_profile, except: :destroy
        resources :projects, only: [:index, :create, :show, :update, :destroy]
        resource :follow, only: [:create, :destroy]
        resources :reviews
      end

      resources :projects, only: [:index, :new, :create, :show, :destroy] do
        resources :bids
      end
    end

  resources :projects
  root to: "static_pages#home"

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  devise_scope :user do
  #   get '/sign-up'   => 'users/registrations#new',   :as => :new_user_registration
    get '/sign-in'   => 'devise/sessions#new',       :as => :new_user_session
    post '/sign-in'  => 'devise/sessions#create',    :as => :user_session
    delete '/sign-out'  => 'devise/sessions#destroy',   :as => :destroy_user_session
  end

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
