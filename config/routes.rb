Rails.application.routes.draw do
  # namespace :admin do
  #   get "dashboard/index"
  # end

#   devise_for :users, controllers: {
#   sessions: "users/sessions"
# }

  namespace :admin do
    get "dashboard", to: "dashboard#index"

    get "exports", to: "exports#index"

    get "exports/friends", to: "exports#friends"
    get "exports/posts",   to: "exports#posts"

  end

  namespace :api do
    namespace :v1 do
      resources :friends, defaults: { format: :json }
    end
  end


  resources :posts do
    resources :comments, only: [:create, :edit, :update, :destroy]
  end


  devise_for :users, **{ controllers: { sessions: 'users/sessions' } }

  # devise_for :users
  resources :friends
  # root "friends#index"
  devise_scope :user do
  root to: "devise/sessions#new"
  end
  # root "devise/sessions#new"
  #
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


# Rails.application.routes.draw do
#   # =====================
#   # Devise (UI login/signup/logout)
#   # =====================
#   devise_for :users, controllers: {
#     sessions: "users/sessions"
#   }

#   # =====================
#   # Admin routes
#   # =====================
#   namespace :admin do
#     get "dashboard", to: "dashboard#index"

#     get  "exports", to: "exports#index"
#     post "exports/friends", to: "exports#friends"
#     post "exports/posts",   to: "exports#posts"
#   end

#   # =====================
#   # API (JWT – Postman only)
#   # =====================
#   namespace :api do
#     namespace :v1 do
#       resources :friends, only: [:index, :show], defaults: { format: :json }
#     end
#   end

#   # =====================
#   # Main resources (UI)
#   # =====================
#   resources :friends
#   resources :posts do
#     resources :comments, only: [:create, :edit, :update, :destroy]
#   end

#   # =====================
#   # Root
#   # =====================
#   # root "friends#index"
#   devise_scope :user do
#     root to: "devise/sessions#new"
#   end
# end


