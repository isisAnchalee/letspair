Rails.application.routes.draw do
  devise_for :users, controllers: {
    # sessions: "users/sessions",
    omniauth_callbacks: 'users/omniauth_callbacks'
  }, skip: [:sessions]
  # devise_for :users, :controllers => { :registrations => 'registrations', :omniauth_callbacks => "authentications" }, :skip => [:sessions]

  devise_scope :user do
  #   get '/sign-up'   => 'users/registrations#new',   :as => :new_user_registration
    get '/sign-in'   => 'devise/sessions#new',       :as => :new_user_session
    post '/sign-in'  => 'devise/sessions#create',    :as => :user_session
    get '/sign-out'  => 'devise/sessions#destroy',   :as => :destroy_user_session
  end

  resources :projects
  root to: 'static_pages#home'
end
