Rails.application.routes.draw do
  
# Groups all admin-related routes under /admin
 namespace :admin do
  get "dashboard", to: "dashboard#index"

  get  "exports",         to: "exports#index"
  post "exports/friends", to: "exports#friends"
  post "exports/posts",   to: "exports#posts"
end

# Creates versioned API endpoints under /api/v1
  namespace :api do
    namespace :v1 do
      resources :friends, defaults: { format: :json }
    end
  end

  # Creates CRUD routes for posts and nested comments
  resources :posts do
    resources :comments, only: [:create, :edit, :update, :destroy]
  end

# Sets up all Devise routes for users
  devise_for :users, **{ controllers: { sessions: 'users/sessions' } }

  # Creates full CRUD routes for friends
  resources :friends

  # Redirects users to the login page by default
  devise_scope :user do
  root to: "devise/sessions#new"
  end
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end

