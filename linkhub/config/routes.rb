Rails.application.routes.draw do
  devise_for :users

  # Public marketing page
  root "home#index"

  # Authenticated routes
  authenticate :user do
    get 'dashboard', to: 'dashboard#index', as: :dashboard

    resource :page, only: [:show, :edit, :update] do
      resources :links, only: [:create, :update, :destroy]
    end

    namespace :billing do
      resources :subscriptions, only: [:new, :create]
      post 'portal', to: 'subscriptions#portal'
    end
  end

  # Public link-in-bio pages (must be last to catch all handles)
  get ':handle', to: 'public#show', as: :public_page
  get ':handle/:link_id/track', to: 'public#track', as: :track_link

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check
end
