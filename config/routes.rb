require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  resources :products

  get :cart, controller: :carts, action: :show
  post :cart, controller: :carts, action: :add_item
  post "cart/add_item", controller: :carts, action: :add_item
  delete "cart/:product_id", controller: :carts, action: :remove_from_cart

  get "up" => "rails/health#show", as: :rails_health_check

  root "rails/health#show"
end
