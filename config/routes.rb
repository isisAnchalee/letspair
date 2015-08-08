Rails.application.routes.draw do

  devise_for :users, :controllers => {
    omniauth_callbacks: 'users/omniauth_callbacks',
    sessions: 'users/sessions'
  }

  devise_scope :user do
    match '/users/:id/finish_signup' => 'users/omniauth_callbacks#finish_signup', via: [:get, :patch], :as => :finish_signup
  end

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
end
